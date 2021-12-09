const MAX_SEQUENCE_LENGTH = 113;
const getKey = (obj,val) => Object.keys(obj).find(key => obj[key] === val); // For getting tags by tagid


let model, emodel;
(async function() {
    model = await tf.loadLayersModel('/ner_model.json');
    let outputs_ = [model.output, model.getLayer("attention_vector").output];
    emodel = tf.model({inputs: model.input, outputs: outputs_});
    $('.loading-model').remove();
    $('.form').removeClass("hide");
})();


function word_preprocessor(word) {
  word = word.replace(/[-|.|,|\?|\!]+/g, '');
  word = word.replace(/\d+/g, '1');
  word = word.toLowerCase();
  if (word != '') {
    return word;
  } else {
    return '.'
  }
};

function make_sequences(words_array) {
  let sequence = Array();
  words_array.slice(0, MAX_SEQUENCE_LENGTH).forEach(function(word) {
    word = word_preprocessor(word);
    let id = words_vocab[word];
    if (id == undefined) {
      sequence.push(words_vocab['<UNK>']);
    } else {
      sequence.push(id);
    }  
  });

  // pad sequence
  if (sequence.length < MAX_SEQUENCE_LENGTH) {
    let pad_array = Array(MAX_SEQUENCE_LENGTH - sequence.length);
    pad_array.fill(words_vocab['<UNK>']);
    sequence = sequence.concat(pad_array);
  }

  return sequence;
};

async function make_predict() {
    $(".main-result").html("");

    let words = $('#input_text').val().split(' ');
    let sequence = make_sequences(words);
    let tensor = tf.tensor1d(sequence, dtype='int32')
      .expandDims(0);
    let [predictions, attention_probs] = await emodel.predict(tensor);
    attention_probs = await attention_probs.data();
    
    predictions = await predictions.argMax(-1).data();
    let predictions_tags = Array();
    predictions.forEach(function(tagid) {
      predictions_tags.push(getKey(tags_vocab, tagid));
    });

    let tagged_words = []

    words.forEach(function(word, index) {
      let current_word = word;
      if (['B-ORG', 'I-ORG'].includes(predictions_tags[index])) {
        tagged_words.push([current_word, 'ORG'])
        current_word += " <span class='badge badge-primary'>"+predictions_tags[index]+"</span>";
      };
      if (['B-PER', 'I-PER'].includes(predictions_tags[index])) {
        tagged_words.push([current_word, 'PER'])
        current_word += " <span class='badge badge-info'>"+predictions_tags[index]+"</span>";
      };
      if (['B-LOC', 'I-LOC'].includes(predictions_tags[index])) {
        tagged_words.push([current_word, 'LOC'])
        current_word += " <span class='badge badge-success'>"+predictions_tags[index]+"</span>";
      };
      if (['B-MISC', 'I-MISC'].includes(predictions_tags[index])) {
        tagged_words.push([current_word, 'MISC'])
        current_word += " <span class='badge badge-warning'>"+predictions_tags[index]+"</span>";
      };

      // uncomment this to show the result on html
      // $(".main-result").append(current_word+' ');
    });

    console.log(words)
    console.log(tagged_words)

    plot_graph(tagged_words)
};

$("#get_ner_button").click(make_predict);
$('#input_text').keypress(function (e) {
    if (e.which == 13) {
      make_predict();
    }
  });

function plot_graph(tagged_words){
  const nodes = []
  const edges = []
  for(let i=0; i<tagged_words.length; i+=1){
    tagged_words[i] = tagged_words[i][0] + ' ' +  tagged_words[i][1]
    nodes.push({ data: { id: tagged_words[i], name: tagged_words[i]} })
  }
  for(let i=1; i<tagged_words.length; i+=1)
    edges.push(({ data: { source: tagged_words[i-1], target: tagged_words[i] } }))

  // console.log(tagged_words)
  // console.log(nodes)
  // console.log(edges)

  var cy = cytoscape({
    container: $("#cy"),
    layout: {
      name: 'concentric',
      concentric: function(n){ return n.id() === 'j' ? 200 : 0; },
      levelWidth: function(nodes){ return 100; },
      minNodeSpacing: 100
    },
    style: [
      {
        selector: 'node[name]',
        style: {
          'content': 'data(name)'
        }
      },

      {
        selector: 'edge',
        style: {
          'curve-style': 'bezier',
          'target-arrow-shape': 'triangle'
        }
      },
    ],

    elements: {
      nodes: nodes,
      edges: edges
    }
  });

  $("#cy").height(400)
  cy.resize()
}
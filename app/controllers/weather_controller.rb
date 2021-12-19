require 'net/http'
require 'csv'

class WeatherController < ApplicationController
  skip_before_action :verify_authenticity_token

  def upload
    if params[:file] != nil
      rowarray = Array.new
      myfile = params[:file]
      import(myfile.path)
      redirect_to '/plot'
    end
  end
  
  def import(myfile)
    data = []
    CSV.foreach(myfile, headers: true) do |row|
      data << row.to_hash
    end
    # puts data

    # reformatting data
    @@imported_data = {}
    data[0].keys.each{ |k| @@imported_data[k] = []}
    data.each{ |x| 
      x.each{ |k,v| 
        @@imported_data[k] << v
      }
    }
  end
  
  def split_query(query)
    query.split
  end
  
  def get_common_types(words)
    words.map(&:downcase) & ['line', 'scatter', 'bar']
  end
  
  def get_common_cols(words, labels)
    words.map(&:downcase) & labels.map(&:downcase)
  end
  
  def col_check_error(common_cols)
    if common_cols.length < 2
      'Could not find two data columns in your query'
    else
      nil
    end
  end
  
  def type_check_error(common_types)
    if common_types.length < 1
      'Could not find chart type in your query'
    else
      nil
    end
  end
  
  def arrange_plot(common_cols, common_types)
    return common_cols[0], common_cols[1], common_types[0]
  end
  
  def draw_plot(data1, data2, col1, col2, plot_type)
    if plot_type == 'line'
      data1 = data1.map(&:to_f)
      data2 = data2.map(&:to_f)
      chart_data = {
        col1 => data1,
        col2 => data2,
      }.to_json
      n = data1.length
      chart_labels = (1..n).to_a
    elsif plot_type == 'bar'
      joint = data1.zip(data2)
      chart_data = Hash[joint].to_json
    else        
      joint = data1.zip(data2) 
      chart_data = joint.map{ |x,y| {'x': x, 'y': y}}.to_json
    end
    # puts @chart_data
    # puts @chart_labels
    # puts @plot_type
    return chart_data, chart_labels
  end

  def plot(*args)
    data = @@imported_data

    # get the keys
    @labels = data.keys

    if request.post?
      if request.POST["query"] != nil
        # type 2 - where the user writes queries
        words = split_query(request.POST["query"])
        
        # find common words b/t query and data columns
        common_cols = get_common_cols(words, @labels)
        
        @error = col_check_error(common_cols)

        common_types = get_common_types(words)

        @error = type_check_error(common_types)

        if !@error
          @col1, @col2, @plot_type = arrange_plot(common_cols, common_types)
        end
      else
        # type 1 - where the user selects columns

        # get selected columns
        @col1 = request.POST['column1']
        @col2 = request.POST['column2']
        @plot_type = request.POST['plot_type']
      end

      if !@error 
        # convert to x,y format
        data1 = data[@col1]
        data2 = data[@col2]
        @chart_data, @chart_labels = draw_plot(data1, data2, @col1, @col2, @plot_type)
      end
    end
  end
end

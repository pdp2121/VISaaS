require 'net/http'
require 'csv'

class WeatherController < ApplicationController
  skip_before_action :verify_authenticity_token

  def data
    if request.post?
      cityname = request.POST['cityname']
      if cityname == ''
        @error = 'invalid city name'
      else
        @weather = get_current_weather(cityname)
        session[:weather] = @weather
        if @weather == nil
          @error = 'invalid city name'
        end
      end
      # puts @weather != nil
    end
  end

  def forecast
    if request.post?
      @city = request.POST['city_name']
      @forecast, @times = get_forecast(@city)
      @times = @times.join(',')
      if @forecast == nil
        @error = 'Error fetching forecast'
      end
    end
  end
  
  def data_download
    # puts session[:weather]
    data = session[:weather].to_json
    send_data data, :type => 'application/json; header=present', :disposition => "attachment; filename=data.json"
  end

  def upload
    if params[:file] != nil
      rowarray = Array.new
      myfile = params[:file]
      data = []
      CSV.foreach(myfile.path, headers: true) do |row|
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
      
      redirect_to '/plot'
    end
  end

  def plot(*args)
    data = @@imported_data

    # get the keys
    @labels = data.keys

    if request.post?
      if request.POST["query"] != nil
        # type 2 - where the user writes queries
        query = request.POST["query"]
        words = query.split
        
        # find common words b/t query and data columns
        common_cols = words & @labels

        if common_cols.length < 2
          @error = 'Could not find two data columns in your query'
        end

        common_types = words & ['line', 'scatter']

        if common_cols.length < 1
          @error = 'Could not find chart type in your query'
        end

        if !@error
          @col1 = common_cols[0]
          @col2 = common_cols[1]
          @plot_type = common_types[0]
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

        if @plot_type == 'line'
          data1 = data1.map(&:to_f)
          data2 = data2.map(&:to_f)
          @chart_data = {
            @col1 => data1,
            @col2 => data2,
          }.to_json
          n = data1.length
          @chart_labels = (1..n).to_a
        else        
          joint = data1.zip(data2) 
          @chart_data = joint.map{ |x,y| {'x': x, 'y': y}}.to_json
        end
        # puts @chart_data
      end
    end
  end

  private
    @@api_key = "ade2a800bae9976517a8880b320bab8c"
    @@base_url = "http://api.openweathermap.org/data/2.5/weather?"
    
    def get_current_weather(city_name)
      complete_url = @@base_url + "&q=" + city_name + "&appid=" + @@api_key + "&q=" + city_name
      url = URI.parse(complete_url)
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      x = JSON.parse(res.body)
      if x["cod"] != "404"
        y = x["main"]
        ret = {}
        ret["current_temperature"] = (y["temp"] - 273.15).round(2)
        ret["current_pressure"] = y["pressure"].round(2)
        ret["current_humidity"] = y["humidity"].round(2)
        ret["description"] = x["weather"][0]["description"]
        return ret
      else
        return nil
      end
    end 

    def get_forecast(city_name) 
      complete_url = 'http://api.openweathermap.org/data/2.5/forecast?appid=' + @@api_key + "&q=" + city_name + '&units=metric'
      url = URI.parse(complete_url)
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      x = JSON.parse(res.body)
      if x['cod'] == '200'
          l = x['list']
          temp = l.map { |y| y['main']['temp'] }
          time = l.map { |y| y['dt_txt']       }
          return temp, time
      else
          return nil
      end
    end
end

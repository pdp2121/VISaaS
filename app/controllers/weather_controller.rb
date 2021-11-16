require 'net/http'

class WeatherController < ApplicationController
  skip_before_action :verify_authenticity_token

  def data
    if request.post?
      cityname = request.POST['cityname']
      @weather = get_current_weather(cityname)
      if @weather == nil
        @error = 'invalid city name'
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

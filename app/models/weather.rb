require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class Weather < ApplicationRecord
    @api_key = = "ade2a800bae9976517a8880b320bab8c"
    @base_url = "http://api.openweathermap.org/data/2.5/weather?"

    def self.getCurrentWeather(city):
        complete_url = @base_url + "&q=" + city + "&appid=" + @api_key
        uri = URI(complete_url)
        res = Net::HTTP.get_response(uri)
        res_body = JSON.parse res.body.read

    def self.forecast(city):
        complete_url = 'http://api.openweathermap.org/data/2.5/forecast?appid=' + @api_key + "&q=" + city + '&units=metric'
        uri = URI(complete_url)
        res = Net::HTTP.get_response(uri)
        res_body = JSON.parse res.body.read
end

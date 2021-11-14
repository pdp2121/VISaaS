# Requires the Gemfile
require 'bundler' ; Bundler.require
require 'JSON'

set :public_folder, File.dirname(__FILE__)
set :port, 5000


get '/' do
  erb :show_entries, :layout => :layout
end

get '/weather' do
  erb :weather, :layout => :layout
end

get '/weather_visualization' do
  erb :forecast, :layout => :layout
end

get '/login' do
  erb :login, :layout => :layout
end

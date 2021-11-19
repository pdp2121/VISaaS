require 'rails_helper'
require 'weather_controller'

# work-around found at https://github.com/rails/rails/issues/34790
if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

RSpec.describe WeatherController, type: :controller do
  before :each do
    @file = File.join(__dir__, "files/data.csv")
  end
  describe "Getting Current Weather" do
    it "success case" do
      expect(WeatherController.new.get_current_weather('London')).to include("current_humidity")
      expect(WeatherController.new.get_current_weather('London')).to include("current_pressure")
      expect(WeatherController.new.get_current_weather('London')).to include("current_temperature")
      expect(WeatherController.new.get_current_weather('London')).to include("description")
    end
    it "failure case" do
      expect(WeatherController.new.get_current_weather('random (not a city name)')).to eq(nil)
    end
  end
  describe "Getting Forecast" do
    it "success case" do
      expect(WeatherController.new.get_forecast('London')).to be_a_kind_of(Array)
    end
    it "failure case" do
      expect(WeatherController.new.get_forecast('random (not a city name)')).to eq(nil)
    end
  end
  describe "Uploading Data" do
    it "success case" do 
      expect(WeatherController.new.import(File.join(__dir__, "files/data.csv"))).to eq(
        Array[{""=>"1", "temp"=>"80", "time"=>"1"}, {""=>"2", "temp"=>"70", "time"=>"2"}, 
        {""=>"3", "temp"=>"75", "time"=>"3"}, {""=>"4", "temp"=>"65", "time"=>"4"}]
      )
    end
  end
  describe "Filtering Data" do
    it "failure case" do 
      expect(WeatherController.new.filter_city("not a city name")).to eq(
        "invalid city name"
      )
    end
  end
  describe "Filtering Forecast" do
    it "success case" do 
      expect(WeatherController.new.filter_forecast("London")).to include(
        "2021"
      )
    end
    it "failure case" do 
      expect(WeatherController.new.filter_forecast("not a city name")).to eq(
        "Error fetching forecast"
      )
    end
  end
  describe "Splitting Query" do
    it "success case" do 
      expect(WeatherController.new.split_query("Scatter plot of columns X and Y")).to include(
        Array["Scatter", "plot", "of", "columns", "X", "and", "Y"]
      )
    end
  end
end
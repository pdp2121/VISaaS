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
  describe "Downloading Data" do
    it "does not result in error" do
      get :data_download
      p response.headers
    end
  end
  describe "Uploading Data" do
    it "is available" do
      get :upload
      p response.headers
    end
  end
  describe "Forecast" do
    it "is available" do
      get :forecast
      p response.headers
    end
  end
end
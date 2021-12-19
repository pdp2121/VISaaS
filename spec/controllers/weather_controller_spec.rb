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
  describe "Draw plot" do
    it "scatter plot" do 
      expect(WeatherController.new.draw_plot(Array[1, 2, 3], Array[1, 2, 3], "x", "y", "scatter")).to eq(
        Array["[{\"x\":1,\"y\":1},{\"x\":2,\"y\":2},{\"x\":3,\"y\":3}]", nil]
      )
    end
    it "bar plot" do 
      expect(WeatherController.new.draw_plot(Array[1, 2, 3], Array[1, 2, 3], "x", "y", "bar")).to eq(
        Array["{\"1\":1,\"2\":2,\"3\":3}", nil]
      )
    end
    it "line plot" do 
      expect(WeatherController.new.draw_plot(Array[1, 2, 3], Array[1, 2, 3], "x", "y", "line")).to eq(
        Array["{\"x\":[1.0,2.0,3.0],\"y\":[1.0,2.0,3.0]}", [1, 2, 3]]
      )
    end
  end
  describe "Arrange plot" do
    it "success case" do 
      expect(WeatherController.new.arrange_plot(Array["x", "y"], Array["scatter"])).to eq(
        Array["x", "y", "scatter"]
      )
    end
  end
  describe "Get Query Plot Type for Visualization" do
    it "error case" do 
      expect(WeatherController.new.type_check_error(Array[])).to eq(
        'Could not find chart type in your query'
      )
    end
    it "success case" do 
      expect(WeatherController.new.type_check_error(Array["scatter"])).to eq(
        nil
      )
    end
  end
  describe "Get Query Columns for Visualization" do
    it "error case" do 
      expect(WeatherController.new.col_check_error(Array["X"])).to eq(
        'Could not find two data columns in your query'
      )
    end
    it "success case" do 
      expect(WeatherController.new.col_check_error(Array["X", "Y"])).to eq(
        nil
      )
    end
  end
  describe "Get Query Columns for Visualization" do
    it "success case" do 
      expect(WeatherController.new.get_common_cols(Array["scatter", "plot", "of", "columns", "X", "and", "Y"], Array["X", "Y"])).to eq(
        Array["x", "y"]
      )
    end
  end
  describe "Get Query Visualizations" do
    it "success case" do 
      expect(WeatherController.new.get_common_types(Array["scatter", "plot", "of", "columns", "X", "and", "Y"])).to eq(
        Array["scatter"]
      )
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
  describe "Splitting Query" do
    it "success case" do 
      expect(WeatherController.new.split_query("Scatter plot of columns X and Y")).to eq(
        Array["Scatter", "plot", "of", "columns", "X", "and", "Y"]
      )
    end
  end
end
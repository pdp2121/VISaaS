require "test_helper"

class WeatherControllerTest < ActionDispatch::IntegrationTest
  test "should get data" do
    get weather_data_url
    assert_response :success
  end

  test "should get forecast" do
    get weather_forecast_url
    assert_response :success
  end
end

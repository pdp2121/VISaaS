Feature: As a user,
            I want to visualize a dataset

  Scenario: Successful Data Visualization Page
      Given I visualize weather data
      Then I should see "Enter a City Name:"
      And I should see "Weather Forecast"
      But I should not see "Download Data"
      
  Scenario: Successful Visualization Created
      Given I visualize weather data
      When I enter the filter "London" for weather data
      Then I should see "Temperature Forecast for London"
      And I should see "Enter a City Name:"
      But I should not see "Error fetching forecast"
      
  Scenario: Unsuccessful Visualization Created
      Given I visualize weather data
      When I enter the filter "random (not a city name)" for weather data
      Then I should not see "Temperature Forecast"
      But I should see "Enter a City Name:"
      And I should see "Error fetching forecast"
Feature: As a user,
            I want to visualize a dataset

  Scenario: Successful Data Visualization Page
    Given VISaaS is set up
      When I visualize weather data
      Then I should see "Enter a City Name:"
      And I should see "Weather Forecast"
      And I should see "Back to Home Page"
      But I should not see "Download Data"
      
  Scenario: Successful Visualization Created
    Given VISaaS is set up
      And I visualize weather data
      When I enter the filter "London" while visualizing weather data
      Then I should see "Temperature Forecast for London"
      And I should see "Enter a City Name:"
      And I should see "Back to Home Page"
      But I should not see "Error fetching forecast"
      
# will resolve so that it is passing (todo)
#  Scenario: Unsuccessful Visualization Created
#    Given VISaaS is set up
#      And I visualize weather data
#      When I enter the filter "random (not a city name)" while visualizing weather data
#      Then I should not see "Temperature Forecast for London"
#      But I should see "Enter a City Name:"
#      And I should see "Back to Home Page"
#      And I should see "Error fetching forecast"
Feature: As a user,
            I want to analyze filtered open-source data

  Scenario: Successful Filter Application
     Given VISaaS is set up
      And I choose weather data
      When I enter the filter "London" for weather data
      Then I should see "Enter a City Name:"
      And I should see "Weather Data"
      And I should see "Back to Home Page"
      And I should see "Download Data"
      And I should see "Current temperature:"
      But I should not see "Invalid city name"
      
  Scenario: Unsuccessful Filter Application
     Given VISaaS is set up
      And I choose weather data
      When I enter the filter "random (not a city name)" for weather data
      Then I should see "Enter a City Name:"
      And I should see "Weather Data"
      And I should see "Back to Home Page"
      And I should see "Download Data"
      But I should not see "Current temperature:"
      And I should see "Invalid city name"
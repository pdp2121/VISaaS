Feature: As a user,
            I want to analyze open-source data

  Scenario: Successful Dataset Selection
     Given VISaaS is set up
      When I choose weather data
      Then I should see "Weather Data"
      And I should see "Enter a City Name:"
      And I should see "Back to Home Page"
      And I should not see "Current temperature:"
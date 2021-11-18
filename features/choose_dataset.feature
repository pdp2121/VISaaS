Feature: As a user,
            I want to analyze open-source data

  Scenario: Successful Dataset Selection
      Given I choose weather data
      Then I should see "Weather Data"
      And I should see "Enter a City Name:"
      And I should not see "Current temperature:"
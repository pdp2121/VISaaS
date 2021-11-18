Feature: As a user,
            I want to download the open-source data

  Scenario: Successful Data Download
      Given I choose weather data
      And I enter the filter "London" for weather data
      When I download the data
      Then I should not see "Enter a City Name:"
      And I should not see "Weather Data"
      But data.json should be downloaded
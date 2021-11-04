Feature: As a user,
            I want to download the open-source data

  Scenario: Successful Data Download
    Given VISaaS is set up
      And I choose weather data
      When I download the weather data
      Then I should not see "Enter a City Name:"
      And I should not see "Weather Data"
      And I should not see "Back to Home Page"
      And I should not see "Download Data"
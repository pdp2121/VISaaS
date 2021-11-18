Feature: As a user,
            I want to analyze other data after analyzing a dataset
            
  Scenario: Successful Return to Home Page
      Given I choose weather data
      When I return to the home page
      Then I should not see "Enter a City Name:"
      And I should not see "Download Data"
      But I should see "Sample Data"
      And I should see "Plot Tools"
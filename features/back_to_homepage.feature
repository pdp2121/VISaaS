Feature: As a user,
            I want to analyze other data after analyzing a dataset
            
  Scenario: Successful Return to Home Page
      Given I choose worldmap
      When I return to the home page
      Then I should not see "Update map"
      But I should see "Upload & Plot your data"
      And I should see "Knowledge Graph"
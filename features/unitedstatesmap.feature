Feature: As a user,
            I want to create a US map with my own data

  Scenario: Successful US Map Creation
      Given I choose usmap
      Then I should see "Update map"
      And I should see "Try updating the values in the sheet below"
      But I should not see "Upload & Plot your data"
      When I click "Update map"
      Then I should see "Update map"
      And I should see "Try updating the values in the sheet below"
      But I should not see "Upload & Plot your data"
Feature: As a user,
            I want to create a Knowledge Graph with my own text data

  Scenario: Successful Knowledge Graph Creation
      Given I choose knowledge
      Then I should see "Create Knowledge Graph"
      And I should see "Enter sentence like:"
      And I should see "The European Commission said that nuclear Energy may be dangerous"
      And I should see "Search Entities"
      But I should not see "Upload & Plot your data"
      Then I should see "Create Knowledge Graph"
      And I should see "Enter sentence like:"
      And I should see "The European Commission said that nuclear Energy may be dangerous"
      And I should see "Search Entities"
      But I should not see "Upload & Plot your data"
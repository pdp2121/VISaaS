Feature: As a user,
            I want to create an animated US map GIF with my own timeseries data

  Scenario: Successful US Map GIF Creation
      Given I choose animatedusmap
      Then I should see "preview GIF"
      And I should see "Slide to change the column"
      But I should not see "Upload & Plot your data"
      When I click "preview GIF"
      Then I should see "preview GIF"
      And I should see "Slide to change the column"
      But I should not see "Upload & Plot your data"
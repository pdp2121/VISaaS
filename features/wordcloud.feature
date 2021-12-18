Feature: As a user,
            I want to create a word cloud with my own text data

  Scenario: Successful Word Cloud Creation
      Given I choose wordcloud
      Then I should see "Update Cloud"
      And I should see "Download as SVG"
      But I should not see "Upload & Plot your data"
      When I click "Update Cloud"
      Then I should see "Update Cloud"
      And I should see "Download as SVG"
      But I should not see "Upload & Plot your data"
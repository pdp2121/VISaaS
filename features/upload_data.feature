Feature: As a user,
            I want to visualize my own dataset

  Scenario: Successful Data Upload and line graph from labels
      Given I go to plot my own data
      Then I should see "Upload Data"
      And I should see "To create graph"
      When I upload my own valid csv
      And I select "temp" and "time" as the variables of interest
      And I create a "Line Graph" plot type
      Then I should see "Copy & Paste this code anywhere"
      
  Scenario: Successful Data Upload and scatter plot from labels
    Given I go to plot my own data
    Then I should see "Upload Data"
    And I should see "To create graph"
    When I upload my own valid csv
    And I select "time" and "temp" as the variables of interest
    And I create a "Scatter Plot" plot type
    Then I should see "Copy & Paste this code anywhere"
    
  Scenario: Succesfuly Data Upload and Query Visualization
    Given I go to plot my own data
    Then I should see "Upload Data"
    And I should see "To create graph"
    When I upload my own valid csv
    And I enter "Scatter plot between column temp and time" as a query
    Then I should see "Copy & Paste this code anywhere"
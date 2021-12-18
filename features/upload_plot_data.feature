Feature: As a user,
            I want to visualize my own dataset

  Scenario: Successful Data Upload
      Given I choose upload
      Then I should see "Upload Data"
      And I should see "To create graph"
      When I upload my own valid csv
      Then I should see "Graph Your Data"
      And I should see "Choose label 1:"
      And I should see "Choose label 2:"
      And I should see "Plot Type:"
      And I should see "time"
      And I should see "temp"
      And I should see "Scatter Plot"
      And I should see "Line Graph"
      And I should see "Bar Chart"
      
  Scenario: Successful Data Upload and scatter plot from labels
    Given I choose upload
    When I upload my own valid csv
    And I select "time" and "temp" as the variables of interest
    And I create a "Scatter Plot" plot type
    Then I should see "Copy & Paste this code anywhere"
    
  Scenario: Successful Data Upload and bar chart from labels
    Given I choose upload
    When I upload my own valid csv
    And I select "time" and "temp" as the variables of interest
    And I create a "Bar Chart" plot type
    Then I should see "Copy & Paste this code anywhere"
    
  Scenario: Successful Data Upload and line graph from labels
    Given I choose upload
    When I upload my own valid csv
    And I select "time" and "temp" as the variables of interest
    And I create a "Line Graph" plot type
    Then I should see "Copy & Paste this code anywhere"
    
  Scenario: Succesfuly Data Upload and Query Visualization
    Given I choose upload
    When I upload my own valid csv
    And I enter "Scatter plot between column temp and time" as a query
    Then I should see "Copy & Paste this code anywhere"
    

Feature: Create ACal
  Scenario: Create and save academic calendar from blank
    Given I am logged in as admin
    When I create a new Academic Calendar
    Then I should be able to save it, and the Make Official button should become active

  Scenario: Search for newly created academic calendar using whole name
    Given I create a new Academic Calendar
    And I save the new academic calendar
    When I search for the Academic Calendar
    Then it should appear in search results

  Scenario: Make Academic Calendar Official
    Given I create a new Academic Calendar
    And I save the new academic calendar
    When I click Make Official
    And I search for the Academic Calendar
    Then my new calendar should be set to Official

  Scenario: Create acal from copy
    Given I create a new Academic Calendar
    And I save the new academic calendar
    And I search for the Academic Calendar
    When I copy the calendar
    Then I should be able to save it, and the Make Official button should become active

  Scenario: Update Academic Calendar
    Given I create a new Academic Calendar
    And I save the new Academic Calendar
    When I update the Academic Calendar
    And I search for the Academic Calendar
    Then my new calendar should reflect the updates

  Scenario: Delete Academic Calendar.
    Given I create a new Academic Calendar
    And I save the new Academic Calendar
    When I delete the Academic Calendar
    Then my new calendar should no longer appear in search results

  Scenario: Search for Academic Calendar using wildcard
    Given I create a new Academic Calendar
    And I save the new Academic Calendar
    When I search for the new Academic Calendar using wildcard
    Then my new calendar should appear in search results

  Scenario: Search for Academic Calendar using partial name
    Given I create a new Academic Calendar
    And I save the new Academic Calendar
    When I search for the new Academic Calendar using partial name
    Then my new calendar should appear in search results


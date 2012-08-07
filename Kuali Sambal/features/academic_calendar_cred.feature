Feature: Academic Calendar CRED
  Scenario: Create and save academic calendar from blank
    Given I am logged in as admin
#    When I create a new Academic Calendar
#    Then I should be able to save it, and the Make Official button should become active
#
#  Scenario: Search for newly created academic calendar
#    Given I create a new Academic Calendar
#    And I save the new Academic Calendar
#    When I search for the Academic Calendar
#    Then the calendar should appear in search results
#
#  Scenario: Make Academic Calendar Official
#    Given I create a new Academic Calendar
#    And I save the new Academic Calendar
#    When I click Make Official
#    And I search for the Academic Calendar
#    Then the calendar should be set to Official
#
#  Scenario: Copy an Academic Calendar
#    Given I create a new Academic Calendar
#    And I save the new Academic Calendar
#    And I search for the Academic Calendar
#    When I copy the calendar
#    Then I should be able to save it, and the Make Official button should become active
#
#  Scenario: Update Academic Calendar
#    Given I create a new Academic Calendar
#    And I save the new Academic Calendar
#    When I update the Academic Calendar
#    And I search for the Academic Calendar
#    Then the calendar should reflect the updates
#
#  Scenario: Delete Academic Calendar
    Given I create a new Academic Calendar
    And I save the new Academic Calendar
    When I delete the Academic Calendar draft
    And I search for the Academic Calendar
    Then the calendar should not appear in search results

#  Scenario: Search for Academic Calendar using wildcards
#    Given I create a new Academic Calendar
#    And I save the new Academic Calendar
#    When I search for the Academic Calendar with wildcards
#    Then the calendar should appear in search results
#
#  Scenario: Search for Academic Calendar using partial name
#    Given I create a new Academic Calendar
#    And I save the new Academic Calendar
#    When I search for the Academic Calendar using partial name
#    Then the calendar should appear in search results
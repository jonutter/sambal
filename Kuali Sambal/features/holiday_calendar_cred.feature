Feature: Holiday Calendar CRED

  Scenario: Create and save Holiday Calendar from blank
      Given I am logged in as Admin
      When I create a Holiday Calendar (from blank)
      Then I should be able to save it, and the Make Official button should become active

  Scenario: Search for newly created Holiday Calendar
      Given I create a Holiday Calendar
      And I save the Holiday Calendar
      When I search for the Holiday Calendar
      Then the calendar should appear in search results

  Scenario: Make Holiday Calendar Official
      Given I create a Holiday Calendar
      And I save the Holiday Calendar
      When I click Make Official
      And I search for the Holiday Calendar
      Then the calendar should be set to Official


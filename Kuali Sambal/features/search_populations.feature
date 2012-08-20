Feature: Search for an existing population

In order to avoid creating a duplicate population (alternate: In order to modify an existing population)
I want to search for a population

  Scenario: Search for existing population by Name
    Given I am logged in as admin
    When I search populations for keyword "New Freshmen"
    Then the search results should include a population where "Name" includes "New Freshmen"

  Scenario: Search for existing population by description
    When I search populations for keyword "60-89 credit hours"
    Then the search results should include a population where "Description" includes "60-89 credit hours"

  Scenario: Search for existing population by state
    When I search for "Active" populations
    Then the search results should only include "Active" populations

  Scenario: Search for existing population by name and state
    Given a population "Athletic Managers & Trainers" is set to state "Inactive"
    When I search populations for keyword is "Athletic Managers & Trainers" and state "Inactive"
    Then the search results should include a population with "Name" "Athletic Managers & Trainers" and "State" "Inactive"

  Scenario: View read-only details of population
    When I search populations for keyword is "Athlete"
    And select population with name "Athlete" from the search results
    Then a read-only view of the population is displayed
    And the view of the population "name" field is "Athlete"
    And the view of the population "description" field is "Students who are members of an NCAA certified sport"
    And the view of the population "type" field is "rule"
    And the view of the population "state" field is "active"

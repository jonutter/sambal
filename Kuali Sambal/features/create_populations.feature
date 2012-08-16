Feature: Create Populations

In order to reserve seats in a course offering for a group of students 
I want to create populations by using rules, and based other populations

  Scenario: Create a new population using a rule
    Given I am logged in as admin
    When I create a population that is rule-based
    Then the population exists with a state of "active"

  Scenario: Create a population using Union operation
    When I create a population that is union-based
    Then the population exists with a state of "active"

  Scenario: Create a population using Exclusion operation
    When I create a population that is exclusion-based
    Then the population exists with a state of "active"

  Scenario: Create a population using Intersection operation
    When I create a population that is intersection-based
    Then the population exists with a state of "active"

  Scenario: Try to create a population using a name that has already been associated with a population
    When I create a population that is rule-based
    And I create another population with the same name
    Then an error message appears stating "Please enter a different, unique population name"
    And there is no new population created

  Scenario: Error when creating a union based pop with only 1 population
    When I try to create a population that is union-based with one population
    Then an error message appears stating "must select at least 2 different populations"

  Scenario: Error creating exclusion based population with no reference population
    When I try to create a population that is exclusion-based with no reference population
    Then an error message appears stating "Reference Population: Required"

  Scenario: Create exclusion based population with 2 populations in addition to the reference population
    When I create an exclusion-based population with 2 additional populations
    Then the population exists with a state of "active"

  Scenario: Create union based based population with 3 populations
    When I create an union-based population with 3 populations
    Then the population exists with a state of "active"
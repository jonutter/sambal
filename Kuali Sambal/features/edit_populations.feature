Feature: Edit populations

In order to reserve seats in a course offering for a group of students 
I want to create populations and in order to effectively manage populations
I want to be able to edit them.

  Scenario: Edit a rule based population
    Given I am logged in as admin
    When I create a population that is rule-based
    And I edit all the fields of a rule-based population
    Then a read-only view of the population is displayed
    And the rule-based population exists with updated data

  Scenario: Edit a population based on a Union operation
    Given I am logged in as admin
    When I create a population that is union-based
    And I update all the editable fields of a union-based population
    Then a read-only view of the population is displayed
    And the union-based population exists with updated data

  Scenario: Edit a population based on an Exclusion operation
    Given I am logged in as admin
    When I create a population that is exclusion-based
    And I update all the editable fields of a exclusion-based population
    Then a read-only view of the population is displayed
    And the exclusion-based population exists with updated data

  Scenario: Edit a population that uses Intersection
    Given I am logged in as admin
    When I create a population that is intersection-based
    And I update all the editable fields of a intersection-based population
    Then a read-only view of the population is displayed
    And the intersection-based population exists with updated data

  Scenario: Try to edit a population using a name that has already been associated with a population
    Given I am logged in as admin
    When I rename a population with an existing name
    Then an error message appears indicating that the Population Name is NOT unique
    And the population name is not changed

  Scenario: Cannot edit the operation type for populations defined by using other populations
    Given I am logged in as admin
    When I edit a union-based population
    Then the population operation type is read-only

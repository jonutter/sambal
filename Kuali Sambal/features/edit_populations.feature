Feature: Edit populations

In order to reserve seats in a course offering for a group of students 
I want to create populations by using rules, and based other populations

Scenario: Edit a rule based population
Given I am logged in as admin
When I create a population that is rule-based
And I edit the name of the population
And I edit the description of the population
And I edit the state of the population
And I edit the rule of the population
Then a read-only view of the population information is displayed
And the population exists with a state of "inactive"

Scenario: Edit a population based on a Union operation
When I create a population that is union-based
And I edit the name of the population
And I edit the description of the population
And I edit the state of the population
And I edit the rule of the population
And I edit the populations of the population
Then a read-only view of the population information is displayed
And the population exists with a state of "inactive"

Scenario: Edit a population based on an Exclusion operation
When I create a population that is exclusion-based
And I edit the name of the population
And I edit the description of the population
And I edit the state of the population
And I edit the rule of the population
And I edit the populations of the population
Then a read-only view of the population information is displayed
And the population exists with a state of "inactive"

Scenario: Create a population using Intersection operation
When I create a population that is intersection-based
And I edit the name of the population
And I edit the description of the population
And I edit the state of the population
And I edit the rule of the population
And I edit the populations of the population
Then a read-only view of the population information is displayed
And the population exists with a state of "inactive"

Scenario: Try to edit a population using a name that has already been associated with a population
When I rename a population with an existing name
Then an error message appears indicating that the Population Name is NOT unique
And the population name is not changed

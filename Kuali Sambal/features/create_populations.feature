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
Then an error message appears indicating that the Population Name is NOT unique
And there is no new population created

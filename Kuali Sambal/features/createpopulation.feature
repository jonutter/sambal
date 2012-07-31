Feature: Create populations

In order to reserve seats in a course offering for a group of students 
I want to create populations by using rules, and based other populations

Scenario: Create a new population using a rule
Given I am logged in as admin
When I create a new rule-based population
Then a population is created with a state of "Active"

Scenario: Create a population using Union operation
Given I am logged in as admin
When I create a new "union" based population:
|description |Combination of two populations - Freshman and Sophomore|
|populations|Freshman,Sophomore|
Then a population is created with a state of "Active"

Scenario: Create a population using Exclusion operation
Given I am logged in as admin
When I create a new "exclusion" based population: 
|description		|All seniors except those who are athletes|
|reference population	|Senior|
|populations		|Athlete|
Then a population is created with a state of "Active"

Scenario: Create a population using Intersection operation
Given I am logged in as admin
When I create a new "intersection" based population:
|description		|All students who are both junior level in standing and athletes|
|populations		|Junior,Athlete|
Then a population is created with a state of "Active"

Scenario: Try to create a population using a name that has already been associated with a population 
Given I am logged in as admin
When I create a new "union" based population named "Early Registration":
|description |Combination of two populations - Freshman and Sophomores|
|populations|Freshman,Sophomore|
Then an error message appears indicating that the Population Name is NOT unique
And there is no new population created

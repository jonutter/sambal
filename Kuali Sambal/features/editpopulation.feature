Feature: Edit populations

In order to reserve seats in a course offering for a group of students 
I want to create populations by using rules, and based other populations

Scenario: Edit a rule based population
Given I am logged on as the Central Administrator
And I create a new "rule" based population:
|description|Students who have earned 90 - 120 credits|
|rule|Senior|
When I edit the name of the new population
And update the attributes of the new population:
|description|Students who have earned 90 - 120 credits updated|
|rule		|Junior|
|state	|inactive|
Then a read only view of the updated "rule" population information is displayed
And the updated "rule" population information persists after performing a new search


Scenario: Edit a population based on a Union operation
Given I am logged on as the Central Administrator
And I create a new "union" based population:
|description |Combination of two populations - Freshman and Sophomore|
|populations|Freshman,Sophomore|
When I edit the name of the new population
And update the attributes of the new population:
|description|Combination of two populations - updated|
|rules	|Freshman,Sophomore|
|state	|inactive|
Then a read only view of the updated "union" population information is displayed
And the updated "union" population information persists after performing a new search

Scenario: Edit a population based on an Exclusion operation
Given I am logged on as the Central Administrator
And I create a new "exclusion" based population: 
|description		|All seniors except those who are athletes|
|reference population	|Senior|
|populations		|Athlete|
When I edit the name of the new population
And update the attributes of the new population:
|description|All athletes except those who are seniors|
|reference population	|Athlete|
|populations		|Senior|
|state	|inactive|
Then a read only view of the updated "exclusion" population information is displayed
And the updated "exclusion" population information persists after performing a new search

Scenario: Create a population using Intersection operation
Given I am logged on as the Central Administrator
And I create a new "intersection" based population:
|description		|All students who are both junior level in standing and athletes|
|populations		|Junior,Athlete|
When I edit the name of the new population
And update the attributes of the new population:
|description|Junior English majors|
|populations		|Junior,ENGL|
|state	|inactive|
Then a read only view of the updated "intersection" population information is displayed
And the updated "intersection" population information persists after performing a new search

Scenario: Try to edit a population using a name that has already been associated with a population 
Given I am logged on as the Central Administrator
When I rename a population named "Freshman" to "Sophomore"
Then an error message appears indicating that the Population Name is NOT unique
And the population name "Freshman" is not changed

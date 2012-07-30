Feature: Search for an existing population

In order to avoid creating a duplicate population (alternate: In order to modify an existing population)
I want to search for a population

Scenario: Search for existing population by Name
Given I am logged on as the Central Administrator
When I search populations for keyword "New Freshmen"
Then the search results should include a population where "Name" includes "New Freshmen"
And the search results should be sortable
And include the columns "Name", "Description", "Type", and "State"

Scenario: Search for existing population by description
Given I am logged on as the Central Administrator
When I search populations for keyword "60-89 credit hours"
Then the search results should include a population where "description" includes "60-89 credit hours"
And the search results should be sortable
And include the columns "Name", "Description", "Rule Type", and "State"

Scenario: Search for existing population by state
Given I am logged on as the Central Administrator
When I search populations for state is "Active"
Then the search results should include a populations with state equals "Active"
And the search results should be sortable
And include the columns "Name", "Description", "Rule Type", and "State"

Scenario: Search for existing population by name and state
Given I am logged on as the Central Administrator
And a population "Athletic Managers & Trainers" is set to state "Inactive"
When I search populations for keyword is "Athletic Managers & Trainers" and state "Inactive"
Then the search results should include a population with "Name" "Athletic Managers & Trainers" and "State" "Inactive"
And the search results should be sortable
And include the columns "Name", "Description", "Rule Type", and "State"
Feature: Create registration groups

As an Administrator, I want to create the registration groups for a Course Offering with a single activity type

  Scenario: Generate registration groups for a course offering with a single activity offering type
    Given I am logged in as admin
    And I manage course offerings for a course offering with a single actvitiy #use ENGL103A (delete if exists, then copy ENGL103)
    When I generate unconstrained registration groups
    Then registration groups are generated for each activity offering

#this is too imperative?
  Scenario: Add to existing registration groups by adding an activity offering
    Given I am logged in as admin
    And I manage course offerings for a course offering with a single actvitiy #use ENGL103A (delete if exists, then copy ENGL103)
    And I generate unconstrained registration groups
    When I add an activity offering
    And I manage registration groups
    Then a warning message is displayed "One or more registration groups are missing"
    And I generate unconstrained registration groups
    Then registration groups are generated for each activity offering
    

#suspend AO functionality in M6?
#  Scenario: Generate registration groups - suspended or cancelled activity offerings are excluded
#    Given I am logged in as admin
#    And I manage course offerings for a course offering with a single actvitiy #use ENGL103A (delete if exists, then copy ENGL103)
#    When I set an activity offering status to cancelled 
#    And I generate unconstrained registration groups
#    Then registration groups are not generated for the activity offering in cancelled status

#suspend CO functionality?
# Scenario: Generate registration groups - cannot be generated for course offering in '???' status (can be generated in Draft,Planned,Offered,Open)
#    Given I am logged in as admin
#    And I manage registration groups for a course offering with a single actvitiy #use ENGL103A (delete if exists, then copy ENGL103)
#    When I set an course offering to '???' #how change course offering status
#    And I generate unconstrained registration groups
#    Then registration groups are not generated for the course offering in '???' status

  Scenario: Copy activity offering to ensure registration groups are copied over
    Given I am logged in as admin
    And I manage course offerings for a course offering with a single activity #use ENGL103A (delete if exists, then copy ENGL103)
    When I copy an activity offering with registration groups
    Then the registration groups are copied over with the activity offering
  
  Scenario: Copy course offering to ensure registration groups are copied over
    Given I am logged in as admin
    And I manage course offerings for a subject area
    When I copy a course offering with registration groups #use ENGL103A (delete if exists, then copy ENGL103)
    Then the registration groups are copied over with the course offering  
  
  Scenario: Rollover course offering to ensure registration groups are copied over
    Given I am logged in as admin
    When I rollover a course offering with registration groups
    Then the registration groups are copied over with the course offering in the target term

  Scenario: Rollover course offering to ensure no registration groups are not automatically generated in the target term
    Given I am logged in as admin
    When I rollover a course offering with no registration groups
    Then the registration groups are not automatically generated with the course offering in the target term
  
  Scenario: Delete activity offering to ensure associated registration groups are deleted
    Given I am logged in as admin
    And I manage registration groups for a course offering with a single actvitiy #use ENGL103A (delete if exists, then copy ENGL103)
    When I delete an activity offering with registration groups
    Then the registration groups are deleted for the activity offering
   
  #how to delete format offering
  #Scenario: Delete format offering to ensure associated registration groups are deleted
  #  Given I am logged in as admin
  
  Scenario: Generate registration groups for a course offering with a mulitple activity offering types
    Given I am logged in as admin
    And I manage course offerings for a course offering with mulitple actvitiy #use CHEM142A (delete if exists, then copy CHEM142)
    When I generate unconstrained registration groups
    Then registration groups are generated for each possible combination of activity offerings
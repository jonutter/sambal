Feature: Create seatpools

As an Administrator, I want to create one or more seat pools and add to my Activity Offering 
so that I can reserve seats in this Activity Offering for one or more populations of students.

  Scenario: Create a seatpool for a population by completing all fields
    Given I am logged in as admin
    And I am managing a course offering
    When I create a seatpool for an activity offering by completing all fields
    Then the seats remaining is updated
    And the percent allocated for each row is updated
    And the seatpool is saved with the activity offering

  Scenario: Warning message displayed when seats in seatpool exceed max enrollment
    Given I am managing a course offering
    When I create a seatpool for an activity offering by completing all fields
    And seats is set higher than max enrollment
    And a warning message is displayed about seats exceeding max enrollment
    And the seatpool is saved with the activity offering

  Scenario:  Seatpools priorities are properly sequenced (1,2,3...) after an activity offering is saved
    Given I am managing a course offering
    When I create seatpools for an activity offering and priorities are duplicated and gapped
    Then the seatpool is saved with the activity offering
    And the seatpool priorities are correctly sequenced

  Scenario:  Cannot add seatpool using a population that is already used for that activity offering
    Given I am managing a course offering
    When I add a seatpool using a population that is already used for that activity offering
    Then an error message is displayed about the duplicate population
    And Given I am managing a course offering

  Scenario: Cannot add seatpool without all required fields
    Given I am managing a course offering
    When I add a seatpool without specifying a population
    Then an error message is displayed about the required fields
    And the seatpool is not saved with the activity offering
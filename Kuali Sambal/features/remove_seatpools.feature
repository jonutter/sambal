Feature: Remove seatpools

As an Administrator, I want to remove one of the seat pools from the Activity Offering 
since this seat pool is no longer needed.

  Scenario: Remove seatpool and ensure seatpool priorities are properly resequenced
    Given I am logged in as admin
    When I create 3 seatpools for an activity offering by completing all fields
    And I remove the seatpool with priority 1
    Then the seats remaining is updated
    And the seatpool removed is removed from the saved activity offering
    And the seatpool priorities are resequenced

  Scenario: Remove all seatpools
    When I create 3 seatpools for an activity offering by completing all fields
    And I remove all seatpools
    Then the seats remaining is updated
    And the seatpool removed is removed from the saved activity offering

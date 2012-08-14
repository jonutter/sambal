Feature: Edit seatpools

As an Administrator, I want to modify attributes of one of the seat pools for the 
Activity Offering so that the seat pool reflects current business needs.

  Scenario: Edit existing seatpool seat count and expiration milestone
    Given I am logged in as admin
    And I am managing a course offering
    When I create a seatpool for an activity offering by completing all fields
    And I edit the seatpool count and expiration milestone
    Then the seats remaining is updated
    And the updated seatpool is saved with the activity offering

  Scenario: Edit existing seatpool priorities
    Given I am managing a course offering
    When I create 2 seatpools for an activity offering by completing all fields
    And I switch the priorities for 2 seatpools
    Then the updated seatpool priorities are saved with the activity offering

  Scenario: Edit total max enrollment
    Given I am managing a course offering
    When I create 2 seatpools for an activity offering by completing all fields
    And I increase the overall max enrollment
    Then the seats remaining is updated
    And the seatpool is saved with the activity offering

Feature: Login credentials via Google Auth and CalNet
    As a Berkeley student,
    I need to have logged in via Google Auth and CalNet 
    Before I can view the map or filter room details,
    So that we can limit what users outside of the campus personnel can see

Background: rooms have been added to database

  Given the following buildings exist:
  | name                   | misc |
  | Haas Faculty Wing      |      |

  And the following rooms exist:
  | number     | capacity   | building_id  | facilities                           | misc                    |
  | F295       | 299        | 1            | ADA-Instructor Accessible            | Lecture Hall            |
  | F269       | 100        | 1            | Whiteboard, Chalkboard               | Classroom, Seminar Hall |

  And  I am on the RoomReservation home page
  And  I am not logged in    

@wip
Scenario: Access needed when clicking buildings on the homepage map when not logged in
    When I click on building "Haas Faculty Wing"
    Then I should see the homepage with "Please log in."
    And I should not see room "F269"

@wip
Scenario: Access not needed when toggling options on the filter bar without filtering without logged in
    When I check the "Seminar Hall" checkbox
    Then I should not see the login page
    And I should be on the RoomReservation home page

@wip
Scenario: Access needed when trying to use the filter bar when logged in
    Given I check the "Seminar Hall" checkbox
    And I click "Filter" button
    Then I should see the login page
    And I should not be on the RoomReservation home page

@wip
Scenario: Allowed to filter if already logged in
    Given I am logged in as "john.doe@berkeley.edu", "John Doe"
    And I check the "Seminar Hall" checkbox
    And I click the "Filter" button
    Then I should be on the RoomReservation home page
  
@wip
Scenario: Allowed to view building details if already logged in
    Given I am logged in as "john.doe@berkeley.edu", "John Doe"
    When I click on building "Haas Faculty Wing"
    Then I should see room "F269"
Feature: Filter rooms with criteria using checkboxes
    
    As a Berkeley student,
    So that I can see rooms which satisfy my needs
    I want to filter rooms by various criteria
    
Background: rooms have been added to database

  Given the following buildings exist:
  | name                   | misc |
  | Test Building 1        |      |
  | Test Building 2        |      |
  | Test Building 3        |      |

  And the following rooms exist:
  | number     | capacity   | building_id  | facilities                        | misc                    |
  | F295       | 299        | 1            | ADA-Student Accessible            | Lecture Hall            |
  | F269       | 100        | 2            | Board-White, Board-Chalk          | Classroom, Seminar Hall |
  | F110       | 50         | 3            | AV-Connection-Aux                 | Lecture Hall            |  

  And  I am on the RoomReservation home page

@wip
Scenario: show filters on homepage
    Then I should see "ADA-Student Accessible"
    And I should see "Whiteboard"
    And I should see "AV Devices"
    And I should see "Capacity"
    And I should see "Room Type"
    And I should see a submit button "Show"
    
Scenario: limit by Student Accessible
    When I check "ADA-Student Accessible"
    And I press "Show"
    Then I should see "Test Building 1"
    And I should not see "Test Building 2"
 
@wip
Scenario: limit by Whiteboard
    When I check "Whiteboard"
    And I press "Show"
    Then I should see "Test Building 2"
    And I should not see "Test Building 1"

@wip
Scenario: limit by Room Type
    When I select "Lecture Hall" from "room_type"
    And I press "Show"
    Then I should see "Test Building 1"
    And I should not see "Test Building 2"
    
Scenario: limit by AV
    When I check "AV"
    And I press "Show"
    Then I should see "Test Building 3"
    And I should not see "Test Building 1"
    And I should not see "Test Building 2"
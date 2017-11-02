Feature: Filter rooms with criteria using checkboxes
    
    As a Berkeley student,
    So that I can see rooms which satisfy my needs
    I want to filter rooms by various criteria
    
Background: rooms have been added to database

  Given the following buildings exist:
  | name                   | misc |
  | Haas Faculty Wing      |      |

  And the following rooms exist:
  | number     | capacity   | building_id  | facilities                           | misc                    |
  | F295       | 299        | 1            | ADA-Student Accessible            | Lecture Hall            |
  | F269       | 100        | 1            | Whiteboard, Chalkboard               | Classroom, Seminar Hall |
  | F110       | 50         | 1            | AV-Connection-Aux                 | Lecture Hall            |  

  And  I am on the RoomReservation home page
  And  I am logged in as "john.doe@berkeley.edu", "John Doe"

@wip
Scenario: show filters on homepage
    Then I should see "Filters"
    And I should see "Student Accessible"
    And I should see "Whiteboard"
    And I should see "Capacity"
    And I should see "Room Type"
    And I should see "AV"

@wip
Scenario: limit by Student Accessible
    When I check "Student Accessible"
    Then I should see room "F295"
    And I should not see room "F269"
 
@wip
Scenario: limit by Whiteboard
    When I check "Whiteboard"
    Then I should see room "F269"
    And I should not see room "F295"

@wip
Scenario: limit by Room Type
    When I select "Room Type" to be "Lecture Hall"
    Then I should see room "F295"
    And I should not see room "F269"
    
@wip
Scenario: limit by AV-*
    When I check "AV-*"
    Then I should see room "F110"
    And I should not see room "F295"
    And I should not see room "F269"
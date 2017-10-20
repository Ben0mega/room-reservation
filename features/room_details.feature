Feature: show room capacity and facilities

    As a Berkeley Student
    So that I can decide which room fits my needs
    I want to see details of any selected room
 
Background: rooms have been added to database

  Given the following buildings exist:
  | name                   | misc |
  | Haas Faculty Wing      |      |

  And the following rooms exist:
  | number     | capacity   | building_id  | facilities                           | misc                               |
  | F295       | 299        | 1            | ADA-Instructor Accessible            | Room Type: Lecture Hall            |
  | F269       | 100        | 1            | Whiteboard                           | Room Type: Classroom, Seminar Hall |

  And  I am on the RoomReservation home page
  
Scenario: show existing rooms when I choose the building 
    When I click on "Haas Faculty Wing"
    Then I should see room "F295"
    And I should see room "F269"
    And I should not see room "42"
 
Scenario: show "Capacity" and "Facilities" under room details page
    When I click on "Haas Faculty Wing"
    And I click on room "F295"
    Then I should see "Capacity" to be "299"
    And I should see "ADA-Instructor Accessible" under "Facilities"

Scenario: show "Room Type" under room details page
    When I click of "Haas Faculty Wing"
    And I click on room "F295"
    Then I should see "Room Type" to be "Lecture Hall"
Feature: Filter rooms with criteria using checkboxes
    
    As a Berkeley student,
    So that I can see rooms which satisfy my needs
    I want to filter rooms by various criteria
    
Background: rooms have been added to database

  Given the following buildings exist:
  | name                   | misc | lat | lng |
  | Test Building 1        |      |     |     |
  | Test Building 2        |      |     |     |
  | Test Building 3        |      |     |     |

  And the following rooms exist:
  | number     | capacity   | building_id  | facilities                        | misc                    |
  | F295       | 299        | 1            | ADA-Student Accessible            | Lecture Hall            |
  | F269       | 100        | 2            | Board-White, Board-Chalk          | Classroom, Seminar Hall |
  | F110       | 50         | 3            | AV-Connection-Aux                 | Lecture Hall            |  

  And  I am on the RoomReservation home page
  And I check "Classroom"
  And I check "Lecture Hall"
  And I check "Auditorium"
  And I check "Seminar Room"
  
Scenario: show filters as three groups
  When I press "Filter"
  Then I should see "Room Type"
  And I should see "Features"
  And I should see "Capacity"

Scenario: show filters on homepage
  When I press "Filter"
  Then I should see "ADA-Student Accessible"
  And I should see "Board"
  And I should see "AV Devices"
  And I should see "Classroom"
  And I should see "Lecture Hall"
  And I should see "Auditorium"
  And I should see "Seminar Room"
  And I should see a button "Show"
  And I should see a button "Reset"
    
Scenario: limit by Student Accessible
  When I press "Filter"
  And I check "ADA-Student Accessible"
  And I press "Show"
  Then I should see "Test Building 1"
  And I should not see "Test Building 2"

Scenario: limit by Board
  When I press "Filter"
  And I uncheck "ADA-Student Accessible"
  And I check "Board"
  And I press "Show"
  Then I should see "Test Building 2"
  And I should not see "Test Building 1"

Scenario: limit by Room Type
  When I press "Filter"
  And I uncheck "Classroom"
  And I uncheck "Auditorium"
  And I uncheck "Seminar Room"
  And I press "Show"
  Then I should see "Test Building 1"
  And I should not see "Test Building 2"
  
Scenario: uncheck all room types
  When I press "Filter"
  And I uncheck "Classroom"
  And I uncheck "Lecture Hall"
  And I uncheck "Auditorium"
  And I uncheck "Seminar Room"
  And I press "Show"
  Then I should not see "Test Building 1"
  And I should not see "Test Building 2"
  
Scenario: limit by AV
  When I press "Filter"
  And I check "AV"
  And I press "Show"
  Then I should see "Test Building 3"
  And I should not see "Test Building 1"
  And I should not see "Test Building 2"
    
Scenario: limit by Capacity
  When I press "Filter"
  And I fill in "capacityLower" with "200"
  And I fill in "capacityUpper" with "299"
  And I press "Show"
  Then I should see "Test Building 1"
  And I should not see "Test Building 2"
  And I should not see "Test Building 3"
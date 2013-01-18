Feature:
  As an english-speaking player
  I want to be able work on events in English
  because want to share it with my friends

Background:
  Given the admin user exists
  And there are 6 events

Scenario: Event listings
  Given I am on the event index page
  When I follow "English"
  Then I should see the title "Event listing"
  And I should see "Event listing" within "h1"
  And I should see "All" within "span.label"
  And I should see "Not yet started" within "span.label"
  And I should see "No date set" within "span.label"
  And I should see "Archived" within "span.label"
  And I should see "Name" within "a"
  And I should see "System" within "a"
  And I should see "Date and Time" within "a"
  And I should see "Duration" within "th"
  And I should see "Deadline" within "th"
  And I should see "Location" within "th"
  And I should see "Reservations" within "th"
  And I should see "Organize event" within "a.btn"
  And I should see "Reserve" within "a.btn"

  Scenario: Show event
    And I am on the event show page
    When I follow "English"
    Then I should see the title "Event details"
    And I should see "System" within "b"
    And I should see "Date and time" within "b"
    And I should see "Deadline" within "b"
    And I should see "Location" within "b"
    And I should see "Reserve" within "a"
    And I should see "Event listing" within "a"
    And I should see "Reservations low"
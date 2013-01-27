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

Scenario: Edit event  (step 1)
  Given a user is logged in
  Given I am on the event edit page
  Then I should see the title "Edit"
  #Buttons
  And I should see "Event details" within "a"
  And I should see "Delete event" within "a"
  And I should see "Event listing" within "a"
  #Step strip
  And I should see "Game" within "a"
  And I should see "When and where" within "a"
  And I should see "Finishes" within "a"
  #Page 1
  And I should see "Name" within "label"
  And I should see "Short description" within "label"
  And I should see "Description" within "label"
  And I should see "Event details" within "a"
  And I should see "Event listing" within "a"
  When I press "Next"
  Then I should see "Event updated"

Scenario: Edit event  (step 2,3,4)
  Given a user is logged in
  Given I am on the event edit page
  When I press "Next"
#Step strip
  Then I should see "Game" within "a"
  And I should see "When and where" within "a"
  And I should see "Finishes" within "a"
  Then I should see "Max players" within "label"
  And I should see "Min players" within "label"
  And I should see "Invited count against"
  When I press "Next"

  Then I should see "Duration" within "label"
  Then I should see "Begins" within "label"
  Then I should see "Reserve by" within "label"
  Then I should see "Location" within "label"
  When I press "Next"


Scenario: New event
  Given a user is logged in
  Given I am on the new event page
  #Step strip
  And I should see "Game" within "a"
  And I should see "When and where" within "a"
  And I should see "Finishes" within "a"
  Then I should see the title "New event"
  When I insert in "event_name" "A name"
  And I press "Next"
  Then I should see "Event created successfully"

Scenario: User events

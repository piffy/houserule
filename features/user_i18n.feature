Feature:
  As an english-speaking player
  I want to be able to access my user info in english
  because I'd love to use this website


Scenario:   Create user (english)
Given I am on the homepage
When I follow "English"
And I follow "Register"
Then I should see the title "Register"
When I insert in "user_name" "Donald"
And  I insert in "user_email" "donald@nomail.it"
And  I insert in "user_password" "12345678"
And  I insert in "user_password_confirmation" "12345678"
And I press "Create user"
Then I should see the title "Home"
And I should see "Donald"

Scenario:   Create user with errors
Given I am on the homepage
When I follow "English"
And I follow "Register"
Then I should see the title "Register"
And I press "Create user"
Then I should see "5 errors have been found"

Scenario:  Show basic user information and navigation in english
Given the admin user exists
  Given I am on the login page
  When I follow "English"
  And  I follow "Login"
  When I insert in "session_email" "admin@nomail.com"
  And I insert in "session_password" "foobar"
  When I press "Login"
#And "admin@nomail.it" organizes the event "Event One"
And I am on the show user page
Then I should see the title "User: admin"
And I should see "admin" within "h1"
And I should see "Administrator" within "span.label"
And I should see "Registered on:" within "b"
And I should see "Location:" within "b"
And I should see "Description" within "b"
And I should see "Organized events" within "a"
And I should see "Reserved events" within "a"
And I should see "Groups" within "b"
And I should see "Index" within "a"
And I should see "Edit user" within "a"
And I should see "Organize event" within "a"
And I should see "Create group" within "a"
And I should see "Delete user" within "a"
#And  I should see "Event One"
#Reservations, invites, etc.

Scenario:  Edit user in English
  Given the admin user exists
  Given I am on the login page
  When I follow "English"
  And  I follow "Login"
  When I insert in "session_email" "admin@nomail.com"
  And I insert in "session_password" "foobar"
  When I press "Login"
  And I am on the edit user page
  Then I should see the title "Preferences"
  And I should see "Edit Admin" within "h1"
  And I should see "Location" within "label"
  And I should see "Description" within "label"
  And I should see "Password" within "label"
  And I should see "Repeat password" within "label"
  And I should see "Index" within "a"
  And I should see "Details for" within "a"
  And I should see "Delete admin" within "a"
  And I should see "Icon provided by"

Scenario:  User index and pagination in English
  Given the admin user exists
  Given I am on the login page
  When I follow "English"
  And  I follow "Login"
  When I insert in "session_email" "admin@nomail.com"
  And I insert in "session_password" "foobar"
  When I press "Login"
  Given there are 32 users
  And I am on the user index page
  Then I should see the title "Users"
  And I should see "Next"
  And I should see "Registered on"
  And I should see "Events"
  And I should see "Groups"
  And I should see "Reservations"



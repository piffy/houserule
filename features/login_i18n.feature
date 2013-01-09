Feature: Login
  To be able to access all features
  As a registered user
  I want to login

Background:
  Given the admin user exists

Scenario:   Login
  Given I am on the login page
  When I follow "English"
  And  I follow "Login"
  Then I should see "forgotten your password"
  And I should see "register"
  When inserisco in "session_email" "admin@nomail.com"
  And inserisco in "session_password" "foobar"
  When I press "Login"

Scenario:   Wrong Login
  Given I am on the login page
  When I follow "English"
  And  I follow "Login"
  When inserisco in "session_email" "admin@nomail.com"
  And inserisco in "session_password" "foo"
  When I press "Login"
  Then I should see "Wrong email or password"

Scenario: Double Login
  Given a user is logged in
  And I am on the login page
  When I follow "English"
  Given I am on the login page
  * mostra la pagina



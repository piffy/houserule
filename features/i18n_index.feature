Feature:
As an english-speaking player
I want to see all the accessible info in english
because I'd love to use this website


Scenario:   Change language
Given I am on the homepage
Then I should see an italian page
And  I should see the image "it.png"
When I follow "English"
Then I should see an english page
When I follow "Italiano"
Then I should see an italian page
And  I should see the image "it.png"





Scenario:   Create user (english)
  Given I am on the homepage
  When I follow "English"
  And I follow "Register"
  Then I should see the title "Register"
  When I insert in "user_name" "Donald"
  And  I insert in "user_email" "donald@nomail.it"
  And  I insert in "user_password" "12345678"
  And  I insert in "user_password_confirmation" "12345678"
  And I press "Create"
  Then I should see the title "Home"
  And I should see "Donald"



Scenario:   Create user with errors
  Given I am on the homepage
  When I follow "English"
  And I follow "Register"
  Then I should see the title "Register"
  And I press "Create"
  Then I should see "5 errors have been found"


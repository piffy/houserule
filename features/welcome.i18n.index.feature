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



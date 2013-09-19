Feature: Authentication

In order to interact with the application
As a user
I want to sign in with my Google account

@sign
Scenario: Not logged in
  Given that I am a new user
  When I go to the homepage
  Then I should see "Sign in"

Scenario: Logging in with Google
  Given that I am a new user
  And I have a valid login
  When I go to the homepage
  And I click "Sign in with Google"
  Then I should be taken to the "Reviews" page

Scenario: Header not displayed on the sign in page
  Given that I am not logged in
  When I go to the homepage
  Then I should not see the header

Scenario: Able to sign out
  Given I go to the homepage
  When I log in as "Homer Simpson"
  Then I should see "Sign Out"

Scenario: See user first name on the homepage
  Given I go to the homepage
  When I log in as "Homer Simpson"
  Then I should see "Homer"

Scenario: After logging out, user should be able to log in
  Given that I am logged in
  And I click "Sign Out"
  Then I should see "Sign in"

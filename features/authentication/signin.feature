Feature: Authentication

In order to interact with the application
As a user
I want to sign in with my Google account

Scenario: Not logged in
  Given that I am a new user
  When I go to the homepage
  Then I should see "Sign in"

Scenario: Logging in with Google
  Given that I am a new user
  And I have a valid login
  When I go to the homepage
  And I click "Sign in with Google"
  Then I should see the reviews page

Scenario: Header not displayed on sign page
  Given that I am not logged in
  When I go to the homepage
  Then I should not see the header

Scenario:
  Given I go to the homepage
  When I log in as "Homer Simpson"
  Then I should see "Sign Out"

Scenario:
  Given I go to the homepage
  When I log in as "Homer Simpson"
  Then I should see "Homer"

Scenario:
  Given I go to the homepage
  When I log in as "Homer Simpson"
  And I click "Sign Out"
  Then I should see "Sign in"

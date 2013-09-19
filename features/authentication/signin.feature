Feature: Authentication

In order to interact with the application
As a new user
I want to see the sign

Scenario: Not logged in
  Given that I am a new user
  When I go to the homepage
  Then I should see the "Sign in" link

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
  When I log in
  Then I should see the "Sign Out" link

Scenario:
  Given I go to the homepage
  When I log in
  And I click "Sign Out"
  Then I should see the "Sign in" link

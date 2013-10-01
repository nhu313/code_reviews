Feature: Authentication

In order to interact with the application
As a user
I want to sign in with my Google account

@sign
Scenario: Not logged in
  Given that I am a new user
  When I go to the homepage
  Then I should see "Sign in"

Scenario: Header not displayed on the sign in page
  Given that I am not logged in
  When I go to the homepage
  Then I should not see the header


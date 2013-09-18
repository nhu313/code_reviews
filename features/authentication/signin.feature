Feature: Authentication

In order to interact with the application
As a new user
I want to see the sign in screen

Scenario: Not logged in
  Given that I am a new user
  When I go to the homepage
  Then I should see a sign in page

Scenario: Menu
  Given that I am a new user
  When I go to the homepage
  Then I should not see the header

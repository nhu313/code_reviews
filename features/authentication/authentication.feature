Feature: Authentication

In order to interact with the application
As a user
I want to be able to sign in with my Google account

Scenario: New user
  Given that I am a new user
  When I go to the homepage
  Then I should see a sign in page

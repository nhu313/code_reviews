Feature: Create Review Request

In order to have my code reviewed
As a user
I want to be able to create a review request

Scenario: Able to see create review link on the homepage
  Given that I am logged in
  When I go to the homepage
  Then I should see "Create Request"

Scenario: Able to go create new request page
  Given that I am logged in
  When I click "Create Request"
  Then I should be taken to the "Create Request" page


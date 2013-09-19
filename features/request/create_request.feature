Feature: Create Review Request

In order to have my code reviewed
As a user
I want to be able to create a review request

Background:
  Given that I am logged in

Scenario: Able to go create new request page
  Given that I am on the homepage
  When I click the "Create Request" link
  Then I should be taken to the "Create Request" page

Scenario: Able to go create new request page
  Given that I am on the "Create Request" page
  And I correctly filled out the request form
  When I click the "Submit" button
  Then I should see "submitted"


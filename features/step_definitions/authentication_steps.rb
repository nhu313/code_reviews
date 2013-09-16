Given(/^that I am a new user$/) do
end

When(/^I go to the homepage$/) do
  visit root_path
end

Then(/^I should see a sign in page$/) do
  page.should have_content("Sign in")
end

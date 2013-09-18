Given(/^that I am a new user$/) do
end

When(/^I go to the homepage$/) do
  visit root_path
end

Then(/^I should see a sign in page$/) do
  page.should have_content("Sign in")
end

Then(/^I should not see the header$/) do
    page.should_not have_selector("header")
end

When(/^I click "(.*?)"$/) do |name|
  click_link(name)
end

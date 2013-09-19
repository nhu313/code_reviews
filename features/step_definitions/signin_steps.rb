Given(/^that I am (a new user|not logged in)$/) do |value|
end

Given(/^I have a valid login$/) do
  mock_google_login
end

When(/^I go to the homepage$/) do
  visit root_path
end

Then(/^I should see the "(.*?)" link$/) do |link|
  page.should have_content(link)
end

Then(/^I should not see the header$/) do
  page.should_not have_selector("header")
end

When(/^I click "(.*?)"$/) do |name|
  click_link(name)
end

Then(/^I should see the reviews page$/) do
  page.should have_content("reviews")
end

When(/^I log in$/) do
  mock_google_login
  click_link("Sign in with Google")
end

def mock_google_login
  @auth_hash = {'provider' => 'google_oauth2',
                'uid' => '123',
                'info' => {'first_name' => 'first name',
                           'last_name' => 'last name',
                            'email' => 'name@email.com'
    }
  }
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(@auth_hash)
end

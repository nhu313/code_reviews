Given(/^that I am (a new user|not logged in)$/) do |value|
end

Given(/^I have a valid login$/) do
  mock_google_login
end

Given(/^that I am logged in$/) do
  visit root_path
  mock_google_login
  click_link("Sign in with Google")
end

When(/^I go to the homepage$/) do
  visit root_path
end

Then(/^I should not see the header$/) do
  page.should_not have_selector("header")
end

When(/^I log in as "(.*?)"$/) do |full_name|
  first_name, last_name = full_name.split(" ")
  mock_google_login(first_name, last_name)
  click_link("Sign in with Google")
end

def mock_google_login(first_name = "first name", last_name = "last name")
  @auth_hash = {'provider' => 'google_oauth2',
                'uid' => '123',
                'info' => {'first_name' => first_name,
                           'last_name' => last_name,
                            'email' => 'name@email.com'
    }
  }
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(@auth_hash)
end

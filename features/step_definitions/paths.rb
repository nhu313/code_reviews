ROUTES = {
  "Reviews" => "reviews",
  "Create Request" => "requests/new"
}

Given(/^that I am on the homepage$/) do
  visit root_path
end

When(/^I go to the homepage$/) do
  visit root_path
end

Given(/^that I am on the "(.*?)" page$/) do |page_name|
  visit ROUTES[page_name]
end

Then(/^I should be taken to the "(.*?)" page$/) do |page_title|
  page.should have_css('h1', :text => page_title)
end

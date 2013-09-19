When(/^I click "(.*?)"$/) do |name|
  click_link(name)
end

Then(/^I should see "(.*?)"$/) do |value|
  page.should have_content(value)
end

Then(/^I should be taken to the "(.*?)" page$/) do |page_title|
  page.should have_css('h1', :text => page_title)
end

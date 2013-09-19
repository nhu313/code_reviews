When(/^I click the "(.*?)" link$/) do |name|
  click_link(name)
end

Then(/^I should see "(.*?)"$/) do |value|
  page.should have_content(value)
end

When(/^I click the "(.*?)" button$/) do |name|
  click_button(name)
end

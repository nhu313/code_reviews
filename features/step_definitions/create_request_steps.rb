Given(/^I correctly filled out the request form$/) do
  fill_in 'Title', :with => 'create request cucumber'
  fill_in 'URL', :with => 'htt://sample.com'
  fill_in 'Description' => "Create request description"
end

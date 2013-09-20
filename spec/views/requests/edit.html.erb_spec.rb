require 'spec_helper'

describe "requests/edit" do
  before(:each) do
    @request = assign(:request, stub_model(Request,
      :title => "MyString",
      :url => "MyString",
      :description => "MyText",
      :user_id => 1
    ))
  end

  it "renders the edit request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", request_path(@request), "post" do
      assert_select "input#request_title[name=?]", "request[title]"
      assert_select "input#request_url[name=?]", "request[url]"
      assert_select "textarea#request_description[name=?]", "request[description]"
      assert_select "input#request_user_id[name=?]", "request[user_id]"
    end
  end
end

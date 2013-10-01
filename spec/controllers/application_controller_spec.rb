require 'spec_helper'

describe ApplicationController do
  context "User" do
    it "gets user id from session" do
      user_id = 1333
      request.session[:user_id] = user_id
      @controller.user_id.should == user_id
    end

    it "gets user first name from session" do
      first_name = "Bill"
      request.session[:user_first_name] = first_name
      @controller.user_first_name.should == first_name
    end

    it "gets the user first name from the database if there is none in session" do
      user = MockUser.new("name")
      User.stub(:find_by_id).and_return(user)
      @controller.user_first_name.should == user.first_name
    end

    class MockUser
      attr_reader :first_name

      def initialize(first_name)
        @first_name = first_name
      end
    end
  end
end

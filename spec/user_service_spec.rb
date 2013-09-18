require 'spec_helper'

module Q
  describe UserService do
    UID = "uid"

    before(:all) do
      @service = UserService.new
      @user_uid = "id11"
      @user_info = Hash["first_name" => "Annie", "last_name" => "Smith", "email" => "annie@email.com"]
      @auth = Hash[UID => @user_uid, "info" => @user_info]
    end

    context "get user id" do
      it "create a new user when user doesn't exist" do
        User.find_by_uid(@user_uid).should  be_nil

        @service.get_user_id(@auth).should_not be_nil

        user = User.find_by_uid(@user_uid)
        user.destroy
      end

      it "gets the user whent user exist" do
        user = FactoryGirl.create(:user, :uid => @user_uid)
        @service.get_user_id(Hash[UID => @user_uid]).should == 1
      end
    end
  end
end

require 'spec_helper'
require 'mocks/q/mock_db_service'

module Q
  class MockUser
    attr_reader :id
    def initialize(id)
      @id = id
    end
  end

  describe UserService do
    let(:db_service){MockDBService.new}
    let(:user_service){UserService.new(db_service)}
    let(:auth){
      user_info = Hash["first_name" => "Annie", "last_name" => "Smith", "email" => "annie@email.com"]
      Hash["uid" => "id111", "info" => user_info]
    }

    context "get user id" do
      it "create a new user when user doesn't exist" do
        user_id = 11123
        db_service.will_create MockUser.new(user_id)
        user_service.user_id_for(auth).should == user_id
      end

      it "gets the user whent user exist" do
        user_id = 11123
        db_service.will_find MockUser.new(user_id)
        user_service.user_id_for(auth).should == user_id
      end
    end
  end
end

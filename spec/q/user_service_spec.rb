require 'spec_helper'
require 'mocks/q/mock_model'
require 'q/user_service'
require 'mocks/q/mock_data'

module Q
  describe UserService do
    let(:model){MockModel.new}
    let(:user_service){UserService.new(model)}
    let(:auth){
      user_info = Hash["first_name" => "Annie", "last_name" => "Smith", "email" => "annie@email.com"]
      Hash["uid" => "id111", "info" => user_info]
    }

    context "get user id" do
      it "create a new user when user doesn't exist" do
        user_id = 11123
        model.create_data = MockData.new(user_id)
        user_service.user_id_for(auth).should == user_id

        expected_attributes = {:uid => auth["uid"]}.merge(convert_hash_key_to_symbol(auth["info"]))
        model.attributes.should == expected_attributes
      end

      def convert_hash_key_to_symbol(hash)
        Hash[hash.map{ |k, v| [k.to_sym, v] }]
      end

      it "gets the user whent user exist" do
        user_id = 11123
        model.data = [MockData.new(user_id)]
        user_service.user_id_for(auth).should == user_id
      end
    end
  end
end

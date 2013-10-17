require 'spec_helper'
require 'q/services/user_service'
require 'q/services/factory'
require 'mocks/q/mock_model'

module Q
  module Services
    describe UserService do
      let!(:model){Factory.models[:user]}
      let(:user_service){Factory.create(:user, 9)}
      let(:auth){
        user_info = Hash["first_name" => "Annie", "last_name" => "Smith", "email" => "annie@email.com"]
        Hash["uid" => "id111", "info" => user_info]
      }

      context "get user id" do
        it "when user doesn't exist" do
          user_id = 11123
          model.create_data = MockModel.new(user_id)

          user_service.user_id_for(auth).should == user_id
          expected_attributes = {:uid => auth["uid"]}.merge(convert_hash_key_to_symbol(auth["info"]))
          model.attributes.should == expected_attributes
        end

        def convert_hash_key_to_symbol(hash)
          Hash[hash.map{ |k, v| [k.to_sym, v] }]
        end

        it "when user exists" do
          user_id = 11123
          model.data = [MockModel.new(user_id)]
          user_service.user_id_for(auth).should == user_id
        end
      end
    end
  end
end

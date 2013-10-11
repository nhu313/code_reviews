require 'q/user_service'
require 'spec_helper'

describe "Sign in" do
  let(:service){Q::UserService.new(User)}
  let(:auth){
    user_info = Hash["first_name" => "Annie", "last_name" => "Smith", "email" => "annie@email.com"]
    Hash["uid" => "id111", "info" => user_info]
  }

  it "creates a new user when user first login" do
    clear_user_with_same_uid
    user_count = User.all.count
    user_id = service.user_id_for(auth)
    User.all.count.should == user_count + 1
  end

  def clear_user_with_same_uid
    users = User.where({:uid => auth["uid"]})
    users.each {|u| u.destroy}
  end

  it "returns a user id when user already exist" do
    new_user_id = service.user_id_for(auth)
    existing_user_id = service.user_id_for(auth)
    new_user_id.should == existing_user_id
  end
end

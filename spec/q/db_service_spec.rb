require 'spec_helper'
require 'q/db_service'

module Q
  describe DBService do
    let(:service) {DBService.new(User)}
    let(:uid) {"something_really_unique111"}

    context "Create" do
      it "creates a record in the databse with the passed in attributes" do
        service.create(user_attributes(uid))
        db_user = User.find_by_uid(uid)
        db_user.should_not be_nil
        db_user.destroy
      end

      it "raises an error if model is invalid" do
        lambda {service.create(user_attributes(nil)).should raise_error ActiveRecord::RecordInvalid}
      end
    end

    context "Find" do
      it "find a record based on attributes" do
        service.create(user_attributes(uid))
        user = service.find({:uid => uid})
        user.uid.should == uid
        user.destroy
      end

      it "finds all the record with the given filter" do
        users = create_multiple_users(2)
        db_users = service.find_all({:first_name => "Iam"})
        db_users.should == users
        delete_multiple_users(users)
      end

      it "should find anything if data doesn't exist" do
        service.find({:uid => uid}).should be_nil
      end
    end

    private
    def user_attributes(uid)
      user = Hash[:uid => uid,
                  :first_name => "Iam",
                  :last_name => "special",
                  :email => "Iam@special.com"]
    end

    def create_multiple_users(count)
      (0...count).inject([]) do |result, number|
        result << service.create(user_attributes(uid + number.to_s))
      end
    end

    def delete_multiple_users(users)
      users.each {|user| user.destroy}
    end
  end
end

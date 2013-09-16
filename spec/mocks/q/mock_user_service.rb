require 'surrogate/rspec'
require 'q/user_service'

module Q
  class MockUserService
    Surrogate.endow(self)
    define(:get_user_id) {|auth| 1}
  end

  describe UserService do
    it "checks UserService" do
      MockUserService.should be_substitutable_for(UserService)
    end
  end
end

require 'surrogate/rspec'
require 'q/user_service'

module Q
  class MockUserService
    Surrogate.endow(self)
    define(:user_id_for) {|auth| 1}
  end

  describe UserService do
    it "checks UserService" do
      MockUserService.should be_substitutable_for(UserService)
    end
  end
end

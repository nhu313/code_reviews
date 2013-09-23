require 'surrogate/rspec'
require 'q/request_service'

module Q
  class MockRequestService
    Surrogate.endow(self)
    define(:initialize) {|model = "model"| }
    define(:create) {|user_id, attributes|}
    define(:requests_for) {|user_id|}
    define(:find) {|request_id|}
    define(:next_request_in_queue) {|user_id|}
  end

  describe RequestService do
    it "checks if MockRequestService is implemented correctly" do
      MockRequestService.should be_substitutable_for(RequestService)
    end
  end
end

require 'surrogate/rspec'
require 'q/review_request_service'

module Q
  class MockReviewRequestService
    Surrogate.endow(self)
    define(:initialize) {|user_id = 1, request_model = "model", skip_model = "model"| }
    define(:create) {|user_id, attributes|}
    define(:user_requests)
    define(:find) {|request_id|}
    define(:next_request_in_queue)
    define(:valid?) {|params| true}
    define(:skip_request){|request|}
  end

  describe ReviewRequestService do
    it "checks if MockRequestService is implemented correctly" do
      MockReviewRequestService.should be_substitutable_for(ReviewRequestService)
    end
  end
end

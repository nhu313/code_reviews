require 'surrogate/rspec'
require 'q/review_request_service'

module Q
  class MockReviewRequestService
    Surrogate.endow(self)
    define(:initialize) {|model = "model"| }
    define(:create) {|user_id, attributes|}
    define(:requests_for) {|user_id|}
    define(:find) {|request_id|}
    define(:next_request_in_queue) {|user_id|}
  end

  describe ReviewRequestService do
    it "checks if MockRequestService is implemented correctly" do
      MockReviewRequestService.should be_substitutable_for(ReviewRequestService)
    end
  end
end

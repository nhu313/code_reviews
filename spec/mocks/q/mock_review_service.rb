require 'surrogate/rspec'
require 'q/review_service'

module Q
  class MockReviewService
    Surrogate.endow(self)
    define(:initialize) {|user_id = "user_id"| }
    define(:user_requests)
    define(:next_request_in_queue)
    define(:user_replies)
  end

  describe ReviewService do
    it "checks if MockReviewService is implemented correctly" do
      MockReviewService.should be_substitutable_for(ReviewService)
    end
  end
end

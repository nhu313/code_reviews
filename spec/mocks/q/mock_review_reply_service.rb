require 'surrogate/rspec'
require 'q/review_reply_service'

module Q
  class MockReviewReplyService
    Surrogate.endow(self)
    define(:initialize) {|user_id = "user_id"| }
    define(:find){|id|}
    define(:user_replies)
    define(:create_review){|params|}
    define(:submit_reply){|id, attributes|}
  end

  describe ReviewRequestService do
    it "checks if MockReviewReplyService is implemented correctly" do
      MockReviewReplyService.should be_substitutable_for(ReviewReplyService)
    end
  end
end

require 'surrogate/rspec'
require 'q/services/review_request'

module Q
  module Services
    class MockReviewRequest
      Surrogate.endow(self)
      define(:initialize) {|user_id = 1, db="db"| }
      define(:create) {|attributes|}
      define(:find) {|request_id|}
      define(:valid?) {|params| true}
      define(:extract_attributes){|r|}
      define(:archive){|r|}
    end

    describe ReviewRequest do
      it "checks if MockRequestService is implemented correctly" do
        MockReviewRequest.should be_substitutable_for(ReviewRequest)
      end
    end
  end
end

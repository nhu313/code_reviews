require 'spec_helper'
require 'q/review_request_queue'
require 'mocks/q/mock_review_request'
require 'mocks/q/mock_skipped_review_request'

module Q
  describe ReviewRequestQueue do
    let(:user_id){9944}
    let(:another_user){user_id + 11}
    let(:queue){ReviewRequestQueue.for(user_id)}
    let(:request_model){Models[:review_request]}
    let(:skipped_request_model){Models[:skipped_review_request]}

    context "user request" do
      it "when the only request in queue is the user" do
        request_model.data = [MockReviewRequest.new(user_id)]
        queue.peek.should be_nil
      end

      it "when the only request in queue is someone else" do
        review_request = create_review_request
        request_model.data = [review_request]
        queue.peek.should == review_request
      end
    end

    context "taken request" do
      it "when the only request is taken" do
        taken_request = create_review_request
        taken_request.review_reply = "taken"
        request_model.data = [taken_request]
        queue.peek.should be_nil
      end

      it "when the only request is not taken" do
        review_request = create_review_request
        request_model.data = [review_request]
        queue.peek.should == review_request
      end
    end

    context "skip request" do
      xit "user skipped a request" do
        skipped_request_id = 999
        skipped_request_model.data = [MockSkippedReviewRequest.new(user_id, skipped_request_id)]
        review_request = create_review_request(skipped_request_id)
        request_model.data = [review_request]
        queue.peek.should be_nil
      end

      it "user NEVER skipped a request before" do
        review_request = create_review_request
        request_model.data = [review_request]
        queue.peek.should == review_request
      end
    end

    xit "when database has user and taken request" do
      skipped_request_id = 999
      skipped_request_model.data = [MockSkippedReviewRequest.new(user_id, skipped_request_id)]
      mock_return_requests(skipped_request_id)
      queue.peek.id.should > skipped_request_id
    end

    def create_review_request(request_id = 11)
      MockReviewRequest.new(another_user, request_id)
    end

    def mock_return_requests(skipped_request_id = 1)
      user_request = MockReviewRequest.new(user_id)
      taken_request = MockReviewRequest.new(user_id + 1)
      taken_request.review_reply = "taken"
      skipped_request = MockReviewRequest.new(user_id + 1, skipped_request_id)
      not_taken_request = MockReviewRequest.new(user_id + 1, skipped_request_id + 1)

      request_model.data = [user_request, taken_request, skipped_request, not_taken_request]
    end

  end
end

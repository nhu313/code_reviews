require 'spec_helper'
require 'q/review_requests'
require 'mocks/q/mock_review_request_factory'
require 'q/services/factory'

module Q
  describe ReviewRequests do
    let(:user_id) {5444}
    let!(:model){Services::Factory.models.add(:review_request)}
    let(:open_requests) {MockReviewRequestFactory.create_open_requests(user_id, 2)}
    let(:completed_requests) {MockReviewRequestFactory.create_completed_requests(user_id, 4)}
    let(:taken_requests) {MockReviewRequestFactory.create_taken_requests(user_id, 3)}

    it "when there are completed request and open requests" do
      model.data = completed_requests + open_requests
      review_requests = ReviewRequests.for(user_id)
      review_requests.completed.should == completed_requests
    end

    it "when all are completed request" do
      model.data = completed_requests
      review_requests = ReviewRequests.new(user_id)
      review_requests.completed.should == completed_requests
    end

    it "when all are open requests" do
      model.data = open_requests
      review_requests = ReviewRequests.for(user_id)
      review_requests.open.should == open_requests
    end

    it "when all are taken requests" do
      model.data = taken_requests
      review_requests = ReviewRequests.for(user_id)
      review_requests.taken.should == taken_requests
    end

    it "is not taken when the request is completed" do
      model.data = completed_requests
      review_requests = ReviewRequests.for(user_id)
      review_requests.taken.should == []
    end

    context "when there are open, taken, and completed requests" do
      before(:each) do
        model.data = open_requests + completed_requests + taken_requests
        @review_requests = ReviewRequests.for(user_id)
      end

      it "has open requests" do
        @review_requests.open.should == open_requests
      end

      it "has completed requests" do
        @review_requests.completed.should == completed_requests
      end

      it "has taken requests" do
        @review_requests.taken.should == taken_requests
      end
    end
  end
end

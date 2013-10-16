require 'spec_helper'
require 'q/review_requests'
require 'mocks/q/mock_review_request'
require 'q/services/factory'

module Q
  describe ReviewRequests do
    let(:user_id) {5444}
    let(:model){Services::Factory.models[:review_request]}

    it "when there is one completed request and one open request" do
      completed_requests = create_completed_requests(1)
      model.data = completed_requests + create_open_requests(1)

      review_requests = ReviewRequests.new(user_id)
      review_requests.completed.should == completed_requests
    end

    it "when all are completed request" do
      completed_requests = create_completed_requests(5)
      model.data = completed_requests

      review_requests = ReviewRequests.new(user_id)
      review_requests.completed.should == completed_requests
    end

    it "when all are open requests" do
      open_requests = create_open_requests(3)
      model.data = open_requests

      review_requests = ReviewRequests.new(user_id)
      review_requests.open.should == open_requests
    end

    it "when all are taken requests" do
      taken_requests = create_taken_requests(2)
      model.data = taken_requests

      review_requests = ReviewRequests.new(user_id)
      review_requests.taken.should == taken_requests
    end

    it "is not taken when the request is completed" do
      completed_requests = create_completed_requests(2)
      model.data = completed_requests

      review_requests = ReviewRequests.new(user_id)
      review_requests.taken.should == []
    end

    context "when there are open, taken, and completed requests" do
      let(:open_requests) {create_open_requests(2)}
      let(:completed_requests) {create_completed_requests(4)}
      let(:taken_requests) {create_taken_requests(3)}

      before(:each) do
        model.data = open_requests + completed_requests + taken_requests
        @review_requests = ReviewRequests.new(user_id)
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

    def create_open_requests(size)
      (0...size).map do |id|
        MockReviewRequest.new(user_id, id)
      end
    end

    def create_completed_requests(size)
      create_taken_requests(size). each {|r| r.completed = true}
    end

    def create_taken_requests(size)
      (0...size).map do |id|
        taken_review = MockReviewRequest.new(user_id, id)
        taken_review.taken = true
        taken_review
      end
    end
  end
end

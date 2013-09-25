require 'spec_helper'
require 'q/review_request_service'
require 'mocks/q/mock_model'

module Q
  describe ReviewRequestService do
    let(:model) {MockModel.new}
    let(:service) {ReviewRequestService.new(model)}
    let(:user_id) {5444}

    context "create request" do
      it "creates a new request" do
        posted_date = "now"
        DateTime.stub(:now).and_return(posted_date)

        params = Hash[:title => "Blog title", :url => "some url", :description => "text**", :random => "something"]

        request = service.create(user_id, params)
        model.attributes.should == expected_attributes(params, posted_date)
      end

      def expected_attributes(params, posted_date)
        params.delete(:random)
        params[:user_id] = user_id
        params[:posted_date] = posted_date
        params
      end
    end

    context "find" do
      it "finds the request given a request id" do
        request_id = 88422;
        service.find(request_id)
        model.filter.should == {:id => request_id}
      end

      it "finds all the requests for" do
        data = ["1", "2"]
        model.data = data
        service.requests_for(user_id).should == data
        model.filter.should == {:user_id => user_id}
      end

      it "gets the next request in queue" do
        mock_requests
        request_in_queue = service.next_request_in_queue(user_id)
        request_in_queue.user_id.should_not == user_id
        request_in_queue.review.should be_nil
      end

      def mock_requests
        user_request = MockRequest.new(user_id)
        taken_request = MockRequest.new(user_id + 1)
        taken_request.review = "taken"
        not_taken_request = MockRequest.new(user_id + 1)
        model.data = [user_request, taken_request, not_taken_request]
      end
    end
  end
end

class MockRequest
  attr_accessor :user_id, :review

  def initialize(user_id)
    @user_id = user_id
  end
end

require 'spec_helper'
require 'q/review_request_service'
require 'mocks/q/mock_model'
require 'mocks/q/mock_review_request'

module Q
  describe ReviewRequestService do
    let(:user_id) {5444}
    let(:request_model) {MockModel.new}
    let(:skip_history_model) {MockModel.new}
    let(:service) {ReviewRequestService.new(user_id, request_model, skip_history_model)}
    let(:params) {Hash[:title => "Blog title", :url => "some url", :description => "text**", :extra_param => "something"]}
    context "create request" do
      it "creates a new request" do
        posted_date = "now"
        DateTime.stub(:now).and_return(posted_date)

        request = service.create(user_id, params.clone)
        request_model.attributes.should == expected_attributes(params, posted_date)
      end

      def expected_attributes(attributes, posted_date)
        attributes.delete(:extra_param)
        attributes[:user_id] = user_id
        attributes[:posted_date] = posted_date
        attributes
      end
    end

    context "find" do
      it "finds the request given a request id" do
        request_id = 88422;
        service.find(request_id)
        request_model.id.should == request_id
      end

      it "finds all the requests for" do
        data = ["1", "2"]
        request_model.data = data
        service.user_requests.should == data
        request_model.filter.should == {:user_id => user_id}
      end

      it "gets the next request in queue" do
        mock_return_requests
        request_in_queue = service.next_request_in_queue
        request_in_queue.user_id.should_not == user_id
        request_in_queue.review_reply.should be_nil
      end

      it "gets the next request in queue when user has skip request history" do
        skipped_request_id = 999
        skip_history_model.data = [MockSkipRequestHistory.new(user_id, skipped_request_id)]
        mock_return_requests(skipped_request_id)
        request_in_queue = service.next_request_in_queue
        request_in_queue.id.should > skipped_request_id
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

    context "validate" do
      it "is invalid when attribute is nil" do
        service.should_not be_valid(nil)
      end

      it "is invalid when there is no title" do
        params.delete(:title)
        service.should_not be_valid(params)
      end

      it "is invalid when there is no url" do
        params.delete(:url)
        service.should_not be_valid(params)
      end

      it "is invalid when there is a description but no title or url" do
        params = Hash[:description => "text**"]
        service.should_not be_valid(params)
      end

      it "is valid when there are title and url, and no description" do
        params.delete(:description)
        service.should be_valid(params)
      end

      it "is valid when there are title, url, and description" do
        service.should be_valid(params)
      end

    end

    context "skip request" do
      let(:request_id){33}

      it "saves the skip request" do
        service.save_skipped_request(request_id)
        expected_attributes = {:user_id => user_id, :review_request_id => request_id}
        skip_history_model.attributes.should == expected_attributes
      end

      it "updates the skip request history when user has skipped a request before" do
        skip_history_model.data = [MockSkipRequestHistory.new(user_id)]
        service.save_skipped_request(request_id)
        expected_attributes = {:review_request_id => request_id}
        skip_history_model.attributes.should == expected_attributes
      end
    end
  end
end


class MockSkipRequestHistory
  attr_reader :user_id, :review_request_id, :id

  def initialize(user_id, review_request_id = 1)
    @user_id = user_id
    @review_request_id = review_request_id
  end
end

require 'spec_helper'
require 'q/review_request_service'
require 'mocks/q/mock_model'
require 'mocks/q/mock_review_request'

module Q
  describe ReviewRequestService do
    let(:user_id) {5444}
    let(:model) {MockModel.new}
    let(:service) {ReviewRequestService.new(model, user_id)}
    let(:params) {Hash[:title => "Blog title", :url => "some url", :description => "text**", :extra_param => "something"]}
    context "create request" do
      it "creates a new request" do
        posted_date = "now"
        DateTime.stub(:now).and_return(posted_date)

        request = service.create(user_id, params.clone)
        model.attributes.should == expected_attributes(params, posted_date)
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
        model.id.should == request_id
      end

      it "finds all the requests for" do
        data = ["1", "2"]
        model.data = data
        service.user_requests.should == data
        model.filter.should == {:user_id => user_id}
      end

      it "gets the next request in queue" do
        mock_return_requests
        request_in_queue = service.next_request_in_queue
        request_in_queue.user_id.should_not == user_id
        request_in_queue.review_reply.should be_nil
      end

      def mock_return_requests
        user_request = MockReviewRequest.new(user_id)
        taken_request = MockReviewRequest.new(user_id + 1)
        taken_request.review_reply = "taken"
        not_taken_request = MockReviewRequest.new(user_id + 1)
        model.data = [user_request, taken_request, not_taken_request]
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
  end
end

require 'q/review_request_service'

describe "creating a new service" do
  let(:user_id) {1}
  let(:service) {Q::ReviewRequestService.new(user_id, ReviewRequest, SkipRequestHistory)}
  let(:params) {Hash[:title => "Blog title", :url => "some url", :description => "text**", :extra_param => "something"]}

  context "create request" do
    it "creates a new request" do
      original_request_count = ReviewRequest.all.count
      review_request = service.create(user_id, params.clone)
      assert_new_request(review_request, original_request_count)
    end

    def assert_new_request(review_request, original_count)
      ReviewRequest.all.count.should == original_count + 1
      review_request.title.should == params[:title]
      review_request.url.should == params[:url]
      review_request.description.should == params[:description]
    end
  end

  context "find" do
    it "finds the request given a request id" do
      request = service.create(user_id, params.clone)
      service.find(request.id).should == request
    end

    it "finds all the requests for" do
      num_new_request = 3
      original_request_count = ReviewRequest.where({:user_id => user_id}).count
      create_requests(user_id, num_new_request)

      service.user_requests.count.should == original_request_count + num_new_request
    end

    def create_requests(user_id_for_request, size)
      (0...size).collect {
        service.create(user_id_for_request, params.clone)
      }
    end

    it "gets the next request in queue" do
      create_requests(user_id + 1, 1)
      request_in_queue = service.next_request_in_queue
      request_in_queue.user_id.should_not == user_id
      request_in_queue.review_reply.should be_nil
    end

    it "gets the next request in queue when user has skip request history" do
      # requests = create_requests(user_id + 1, 2)
      # requests[0].id
      # skip_history_model.data = [MockSkipRequestHistory.new(user_id, skipped_request_id)]
      # mock_return_requests(skipped_request_id)
      # request_in_queue = service.next_request_in_queue
      # request_in_queue.id.should > skipped_request_id
    end
    #
    # def mock_return_requests(skipped_request_id = 1)
    #   user_request = MockReviewRequest.new(user_id)
    #   taken_request = MockReviewRequest.new(user_id + 1)
    #   taken_request.review_reply = "taken"
    #   skipped_request = MockReviewRequest.new(user_id + 1, skipped_request_id)
    #   not_taken_request = MockReviewRequest.new(user_id + 1, skipped_request_id + 1)
    #
    #   request_model.data = [user_request, taken_request, skipped_request, not_taken_request]
    # end
  end

  context "validate" do
    # it "is invalid when attribute is nil" do
    #   service.should_not be_valid(nil)
    # end
    #
    # it "is invalid when there is no title" do
    #   params.delete(:title)
    #   service.should_not be_valid(params)
    # end
    #
    # it "is invalid when there is no url" do
    #   params.delete(:url)
    #   service.should_not be_valid(params)
    # end
    #
    # it "is invalid when there is a description but no title or url" do
    #   params = Hash[:description => "text**"]
    #   service.should_not be_valid(params)
    # end
    #
    # it "is valid when there are title and url, and no description" do
    #   params.delete(:description)
    #   service.should be_valid(params)
    # end
    #
    # it "is valid when there are title, url, and description" do
    #   service.should be_valid(params)
    # end

  end

  context "skip request" do
    # let(:request_id){33}
    #
    # it "saves the skip request" do
    #   service.save_skipped_request(request_id)
    #   expected_attributes = {:user_id => user_id, :review_request_id => request_id}
    #   skip_history_model.attributes.should == expected_attributes
    # end
    #
    # it "updates the skip request history when user has skipped a request before" do
    #   skip_history_model.data = [MockSkipRequestHistory.new(user_id)]
    #   service.save_skipped_request(request_id)
    #   expected_attributes = {:review_request_id => request_id}
    #   skip_history_model.attributes.should == expected_attributes
    # end
  end
end

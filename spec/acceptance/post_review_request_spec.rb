require 'q/review_request_service'
require 'spec_helper'

describe "creating a new request" do
  let(:user_id) {1}
  let(:another_user){2}
  let(:service) {Q::ReviewRequestService.new(user_id, ReviewRequest, SkippedReviewRequest)}
  let(:params) {Hash[:title => "Blog title", :url => "some url",
                     :description => "text**", :extra_param => "something"]}

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
      cleanUserSkipRequests

      create_requests(another_user, 1)
      request_in_queue = service.next_request_in_queue
      request_in_queue.user_id.should_not == user_id
      request_in_queue.review_reply.should be_nil
    end

    it "gets the next request in queue when user has skip request history" do
      cleanUserSkipRequests

      review_requests = create_requests(another_user, 2)
      create_skip_history(review_requests[0].id)
      request_in_queue = service.next_request_in_queue
      request_in_queue.id.should == review_requests[1].id

      review_requests.each {|r| r.destroy}
    end
  end

  context "validate" do
    it "is false when user did not enter all the require attributes" do
      params.delete(:title)
      service.should_not be_valid(params)
    end

    it "is valid when user enters all the required fields" do
      service.should be_valid(params)
    end
  end

  context "skip request" do
    let(:request_id){33}

    it "saves the skip request" do
      service.save_skipped_request(request_id)
      SkippedReviewRequest.find_by({:user_id => user_id}).review_request_id.should == request_id
    end

    it "updates the skip request history when user has skipped a request before" do
      cleanUserSkipRequests
      create_skip_history(request_id - 10)

      service.save_skipped_request(request_id)
      SkippedReviewRequest.find_by({:user_id => user_id}).review_request_id.should == request_id
    end
  end

  def cleanUserSkipRequests
    skippedRequests = SkippedReviewRequest.where({:user_id => user_id})
    skippedRequests.each {|r| r.destroy}
  end

  def create_skip_history(review_request_id)
    SkippedReviewRequest.create({:user_id => user_id, :review_request_id => review_request_id})
  end
end

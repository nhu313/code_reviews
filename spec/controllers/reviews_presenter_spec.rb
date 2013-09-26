require 'spec_helper'
require 'mocks/q/mock_review_request_service'
require 'mocks/q/mock_review_reply_service'

describe ReviewsPresenter do
  let(:user_id){12}
  let(:request_service){Q::MockReviewRequestService.new}
  let(:reply_service) {Q::MockReviewReplyService.new}
  let(:presenter) {ReviewsPresenter.new(request_service, reply_service)}

  it "gets the review requests for the user" do
    requests = "requests"
    request_service.will_have_user_requests requests
    presenter.user_requests.should == requests
  end

  it "gets the next request in queue" do
    next_request = "request"
    request_service.will_have_next_request_in_queue next_request
    presenter.request_in_queue.should == next_request
  end

  it "gets the replies for the user" do
    replies = "replies"
    reply_service.will_have_user_replies replies
    presenter.user_replies.should == replies
  end

end

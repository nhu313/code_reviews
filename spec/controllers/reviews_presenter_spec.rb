require 'spec_helper'
require 'mocks/q/mock_review_service'

describe ReviewsPresenter do
  let(:user_id){12}
  let(:service) {Q::MockReviewService.new}
  let(:presenter) {ReviewsPresenter.new(user_id, service)}

  # it "gets the review requests for the user" do
  #   requests = "requests"
  #   service.will_have_user_requests requests
  #   presenter.user_requests.should == requests
  # end
  #
  # it "gets the next request in queue" do
  #   next_request = "request"
  #   service.will_have_next_request_in_queue next_request
  #   presenter.request_in_queue.should == next_request
  # end
  #
  # it "gets the reviews for the user" do
  #   replies = "replies"
  #   service.will_have_user_replies replies
  #   presenter.user_replies.should == replies
  # end

end

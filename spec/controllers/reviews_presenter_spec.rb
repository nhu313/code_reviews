require 'spec_helper'
require 'mocks/q/mock_review_request_service'

describe ReviewsPresenter do
  let(:user_id){12}
  let(:service) {Q::MockReviewRequestService.new}
  let(:review_service) {MockReviewService.new}
  let(:presenter) {ReviewsPresenter.new(user_id, service, review_service)}

  it "gets the requests for the user" do
    requests = "requests"
    service.will_have_requests_for requests
    presenter.requests.should == requests
  end

  it "gets the next request in queue" do
    next_request = "request"
    service.will_have_next_request_in_queue next_request
    presenter.request_in_queue.should == next_request
  end

  it "gets the reviews for the user" do
    reviews = "reviews"
    review_service.reviews = reviews
    presenter.reviews.should == reviews
  end

end

class MockReviewService

  def reviews=(reviews)
    @reviews = reviews
  end

  def reviews_for(user_id)
    @reviews
  end

end

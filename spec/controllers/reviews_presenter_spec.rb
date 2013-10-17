require 'spec_helper'
require 'q/services/factory'
require 'mocks/q/mock_review_request_factory'

describe ReviewsPresenter do
  let(:user_id){12}
  let(:review_request_model){Q::Services::Factory.models[:review_request]}
  let(:presenter){ReviewsPresenter.new(user_id)}

  it "has the next request in queue" do
    review_requests = MockReviewRequestFactory.create_open_requests(user_id + 1, 2)
    review_request_model.data = review_requests
    presenter.queue.should == review_requests.first
  end

  it "has review requests user submitted" do
    open_requests = MockReviewRequestFactory.create_open_requests(user_id, 2)
    review_request_model.data = open_requests
    presenter.reviews_submitted.should == open_requests
  end

  it "has review requests user took" do
    taken_requests = MockReviewRequestFactory.create_taken_requests(user_id, 2)
    review_request_model.data = taken_requests
    presenter.reviews_taken.should == taken_requests
  end

end

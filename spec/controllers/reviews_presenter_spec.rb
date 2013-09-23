require 'spec_helper'
require 'mocks/q/mock_request_service'

describe ReviewsPresenter do
  let(:service) {Q::MockRequestService.new}

  it "gets the requests for the user" do
    requests = "requests"
    service.will_have_requests_for requests
    presenter = ReviewsPresenter.new(service, 1)
    presenter.requests.should == requests
  end

  it "gets the next request in queue" do
    next_request = "request"
    service.will_have_next_request_in_queue next_request
    presenter = ReviewsPresenter.new(service, 1)
    presenter.request_in_queue.should == next_request
  end

end

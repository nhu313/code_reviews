require 'spec_helper'
require 'q/review_service'
require 'mocks/q/mock_data'
require 'mocks/q/mock_model'

module Q
  describe ReviewService do
    let(:model){MockModel.new}
    let(:request_service) {MockRequestService.new}
    let(:reply_service){MockReplyService.new}
    let(:service){ReviewService.new(model, request_service, reply_service)}

    it "asks request service to get all service for the user" do
      requests = "request"
      request_service.requests = requests
      service.user_requests.should == requests
    end

    it "finds the next item in queue" do

    end

  end
end

class MockRequestService

  def requests=(request)
    @requests = request
  end

  def requests_for(user_id)
    @requests
  end

end

class MockReplyService

end

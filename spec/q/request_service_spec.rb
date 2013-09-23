require 'spec_helper'
require 'q/request_service'
require 'mocks/q/mock_model'

module Q
  describe RequestService do
    let(:model) {MockModel.new}
    let(:service) {RequestService.new(model)}
    let(:user_id) {5444}

    context "create request" do
      it "creates a new request" do
        posted_date = "now"
        DateTime.stub(:now).and_return(posted_date)

        params = Hash[:title => "Blog title", :url => "some url", :description => "text**", :random => "something"]

        request = service.create(user_id, params)
        model.attributes.should == expected_attributes(params, posted_date)
      end

      def expected_attributes(params, posted_date)
        params.delete(:random)
        params[:user_id] = user_id
        params[:posted_date] = posted_date
        params
      end
    end

    context "find" do
      it "finds the request given a request id" do
        request_id = 88422;
        service.find(request_id)
        model.filter.should == {:id => request_id}
      end

      it "finds all the requests for" do
        data = ["1", "2"]
        model.data = data
        service.requests_for(user_id).should == data
        model.filter.should == {:user_id => user_id}
      end

      it "gets the next request in queue" do
        model.data = [MockRequest.new(user_id), MockRequest.new(user_id + 1)]
        service.next_request_in_queue(user_id).user_id.should_not == user_id
      end
    end
  end
end

class MockRequest
  attr_accessor :user_id

  def initialize(user_id)
    @user_id = user_id
  end
end

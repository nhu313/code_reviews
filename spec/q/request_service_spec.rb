require 'spec_helper'
require 'q/request_service'
require 'mocks/q/mock_model'

module Q
  describe RequestService do
    let(:model) {MockModel.new}
    let(:service) {RequestService.new(model)}

    context "create request" do
      it "creates a new request" do
        user_id = 53111
        params = Hash[:title => "Blog title", :url => "some url", :description => "text**"]

        request = service.create(user_id, params)

        params[:user_id] = user_id
        model.attributes.should == params
      end
    end

    context "find" do
      it "finds the request given a request id" do
        request_id = 88422;
        service.find(request_id)
        model.filter.should == {:id => request_id}
      end

      it "finds all the requests for" do
        user_id = 88422;
        service.requests_for(user_id)
        model.filter.should == {:user_id => user_id}
      end

    end
  end
end

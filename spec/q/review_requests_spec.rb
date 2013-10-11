require 'spec_helper'
require 'q/review_requests'
require 'mocks/q/mock_model'
require 'mocks/q/mock_review_request'

module Q
  describe ReviewRequests do
    let(:user_id) {5444}
    let(:request_model) {Models[:review_request]}
    let(:review_requests) {ReviewRequests.new(user_id)}

    context "new request" do
      it "creates" do
        posted_date = "now"
        DateTime.stub(:now).and_return(posted_date)

        request = review_requests.create(params.clone)
        request_model.attributes.should == expected_attributes(params, posted_date)
      end

      def params
        {:title => "Blog title", :url => "some url",
         :description => "text**", :extra_param => "something"}
      end

      def expected_attributes(attributes, posted_date)
        attributes.delete(:extra_param)
        attributes[:user_id] = user_id
        attributes[:posted_date] = posted_date
        attributes
      end
    end

    context "find" do
      it "finds the request given a request id" do
        request_id = 88422;
        review_requests.find(request_id)
        request_model.id.should == request_id
      end

      it "finds all the requests" do
        data = ["1", "2"]
        request_model.data = data
        review_requests.all.should == data
        request_model.filter.should == {:user_id => user_id}
      end

      it "finds active requests" do
        data = ["1", "2"]
        request_model.data = data
        review_requests.active.should == data
        request_model.filter.should == {:user_id => user_id, :archive => false}
      end
    end

    context "archieve request" do
      it "save user preference" do
        review_requests.archive(11)
        expected_attributes = {:archive => true}
        request_model.attributes.should == expected_attributes
      end
    end
  end
end

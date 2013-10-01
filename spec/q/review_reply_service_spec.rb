require 'spec_helper'
require 'q/review_reply_service'
require 'mocks/q/mock_model'
require 'mocks/q/mock_data'

module Q
  describe ReviewReplyService do
    let(:user_id) {4411}
    let(:model){MockModel.new}
    let(:service){ReviewReplyService.new(user_id, model)}

    context "find" do
      it "finds the review given an id" do
        review_id = 11;
        service.find(review_id)
        model.id.should == review_id
      end

      it "finds all the reviews for" do
        data = ["1", "2"]
        model.data = data
        service.user_replies.should == data
        model.filter.should == {:reviewer_id => user_id}
      end
    end

    context "create review" do
      it "creates a new review" do
        review_request_id = 444;
        service.create_review(review_request_id)
        model.attributes.should == {:reviewer_id => user_id, :review_request_id => review_request_id}
      end
    end

    context "submit review" do
      it "submits a review" do
        reply = Hash[:url => "url", :comment => "comment"]
        expected_attributes = expected_reply_attributes(reply)
        service.submit_reply(13, reply)
        model.attributes.should == expected_attributes
      end

      def expected_reply_attributes(params)
        posted_date = "some date"
        DateTime.stub(:now).and_return(posted_date)

        expected_attributes = params.clone
        expected_attributes[:posted_date] = posted_date
        expected_attributes
      end
    end
  end
end
  
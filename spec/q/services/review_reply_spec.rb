require 'spec_helper'
require 'q/services/review_reply'
require 'q/services/factory'

module Q
  module Services
    describe ReviewReply do
      let(:user_id) {4411}
      let!(:model){Factory.models[:review_reply]}
      let(:service){Factory.create(:review_reply, user_id)}

      it "finds the review given an id" do
        review_id = 11;
        service.find(review_id)
        model.id.should == review_id
      end

      it "creates a new reply" do
        DateTime.stub(:now).and_return("posted_date")
        review_request_id = 553
        params = Hash[:url => "url", :comment => "comment"]

        service.create_reply(review_request_id, params)

        model.attributes.should == expected_attributes(params.clone, review_request_id)
      end

      def expected_attributes(attributes, review_request_id)
        attributes[:review_request_id] = review_request_id
        attributes[:posted_date] = DateTime.now
        attributes
      end
    end
  end
end

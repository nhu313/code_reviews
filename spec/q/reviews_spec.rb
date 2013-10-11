require 'spec_helper'
require 'q/reviews'

module Q
  describe Reviews do
    let(:user_id) {5444}
    let(:reviews) {Reviews.for(user_id)}
    let(:data) {["1", "2"]}

    it "has user requested review" do
      request_model = Models[:review_request]
      request_model.data = data

      reviews.requested.should == data
      request_model.filter.should == {:user_id => user_id, :archive => false}
    end

    it "has user taken review" do
      reply_model = Models[:review_reply]
      reply_model.data = data

      reviews.taken.should == data
      reply_model.filter.should == {:reviewer_id => user_id, :posted_date => nil}
    end

  end
end

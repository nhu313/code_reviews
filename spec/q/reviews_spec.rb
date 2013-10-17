require 'spec_helper'
require 'q/services/review_reply'
require 'q/services/factory'
require 'q/reviews'
require 'mocks/q/mock_review_request_factory'

module Q
  describe Reviews do
    let(:user_id) {5444}
    let!(:request_model){Services::Factory.models[:review_request]}
    let(:reviews) {Reviews.for(user_id)}
    let(:data) {[MockReviewRequestFactory.create(user_id),
                 MockReviewRequestFactory.create(user_id)]}

    it "has user submitted reviews" do
      request_model.data = data

      reviews.submitted.should == data
      request_model.filter.should == {:user_id => user_id, :archive => false}
    end

    describe "taken reviews" do
      it "has user taken reviews" do
        request_model.data = data
        reviews.taken.should == data
        request_model.filter.should == {:reviewer_id => user_id}
      end

      it "only return request that has not been completed" do
        set_up_data_with_completed_review
        reviews.taken.should == data
        request_model.filter.should == {:reviewer_id => user_id}
      end

      def set_up_data_with_completed_review
        completed_review = MockReviewRequestFactory.create(user_id)
        completed_review.completed = true

        db_data = data.clone
        db_data[2] = completed_review
        request_model.data = db_data
      end
    end
  end
end

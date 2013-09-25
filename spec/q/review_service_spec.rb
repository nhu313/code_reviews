require 'spec_helper'
require 'q/review_service'
require 'mocks/q/mock_model'
require 'mocks/q/mock_data'

module Q
  describe ReviewService do
    let(:model){MockModel.new}
    let(:service){ReviewService.new(model)}
    let(:user_id) {4411}

    context "find" do
      it "finds the review given an id" do
        review_id = 11;
        service.find(review_id)
        model.filter.should == {:id => review_id}
      end

      it "finds all the reviews for" do
        data = ["1", "2"]
        model.data = data
        service.reviews_for(user_id).should == data
        model.filter.should == {:reviewer_id => user_id}
      end
    end

    context "create review" do

      it "creates a new review" do
        user_id = 1111
        review_request_id = 444;

        service.create_review(user_id, review_request_id)
        model.attributes.should == {:reviewer_id => user_id, :request_id => review_request_id}
      end


    end


  end
end

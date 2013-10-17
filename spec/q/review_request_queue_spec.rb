require 'spec_helper'
require 'q/review_request_queue'
require 'mocks/q/mock_review_request_factory'
require 'mocks/q/mock_skipped_review_request'
require 'mocks/q/mock_model'

module Q
  describe ReviewRequestQueue do
    let(:user_id){9944}
    let(:another_user_id){user_id + 11}
    let!(:request_model){Services::Factory.models[:review_request]}
    let!(:skipped_request_model){Services::Factory.models[:skipped_review_request]}
    let(:queue){ReviewRequestQueue.for(user_id)}

    describe "peek" do
      it "looks for request that is not taken" do
        request_model.data = []
        queue.peek
        request_model.filter.should == {:reviewer_id => nil}
      end

      context "when there is one request" do
        it "has only user request" do
          request_model.data = [MockReviewRequestFactory.create(user_id)]
          queue.peek.should be_nil
        end

        it "has other user request" do
          review_request = MockReviewRequestFactory.create(another_user_id)
          request_model.data = [review_request]
          queue.peek.should == review_request
        end
      end

      context "when user skipped a request before" do
        let(:skipped_date){DateTime.now}
        before(:each) do
          skipped_request_model.data = [MockSkippedReviewRequest.new(user_id, skipped_date)]
        end

        it "has an older request" do
          review_request = MockReviewRequestFactory.create(another_user_id)
          review_request.posted_date = skipped_date - 1

          request_model.data = [review_request]
          queue.peek.should be_nil
        end

        it "has a newer newer request" do
          review_request = MockReviewRequestFactory.create(another_user_id)
          review_request.posted_date = skipped_date + 1

          request_model.data = [review_request]
          queue.peek.should == review_request
        end
      end
    end

    it "takes a request" do
      review_request_id = 8331
      queue.take_request(review_request_id)
      request_model.id.should == review_request_id
      request_model.attributes.should == {:reviewer_id => user_id}
    end

    describe "skip request" do
      let(:review_request_id){522}
      let(:posted_date){DateTime.now}
      let(:review_request){MockReviewRequestFactory.create_with_id(another_user_id, review_request_id)}

      before(:each) do
        review_request.posted_date = posted_date
        request_model.data = [review_request]
      end

      it "saves the date of skipped request" do
        queue.skip_request(review_request_id)
        skipped_request_model.attributes.should == {:user_id => user_id,
                                                    :last_skipped_date => posted_date}
      end

      context "when user skipped a request before" do
        let(:skipped_request){MockModel.new}
        before(:each) do
          skipped_request_model.data = [skipped_request]
        end

        it "updates the skipped date" do
          queue.skip_request(review_request_id)
          skipped_request.attributes.should == {:last_skipped_date => posted_date}
        end

        it "updates the correct skipped review request" do
          queue.skip_request(review_request_id)
          skipped_request_model.id.should == skipped_request.id
        end
      end
    end
  end
end

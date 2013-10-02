require 'spec_helper'

describe ReviewRequest do
  let(:review_request){ReviewRequest.new}
  let(:review_reply){ReviewReply.new}

  describe "When a request is completed" do
    it "is completed when reviewer posted a reply" do
      review_request.stub(:review_reply).and_return(review_reply)
      review_reply.stub(:posted_date).and_return("11/8")
      review_request.should be_completed
    end

    it "is not completed when there is no reply" do
      review_request.stub(:review_reply).and_return(nil)
      review_request.should_not be_completed
    end

    it "is not completed when reviewer did not post a reply" do
      review_request.stub(:review_reply).and_return(review_reply)
      review_reply.stub(:posted_date).and_return(nil)
      review_request.should_not be_completed
    end
  end

  describe "When a request is taken" do
    it "is taken when there is a reply" do
      review_request.stub(:review_reply).and_return(review_reply)
      review_request.should be_taken
    end

    it "is not taken when there is no reply" do
      review_request.should_not be_taken
    end
  end

end

require 'spec_helper'

describe ReviewReply do
  let(:review_reply){ReviewReply.new}

  it "gets the title" do
    review_request = ReviewRequest.new
    review_request.title = "something"
    review_reply.stub(:review_request).and_return(review_request)

    review_reply.title.should == review_request.title
  end

  it "gets the reviewer" do
    reviewer = "reviewer"
    review_reply.stub(:user).and_return(reviewer)
    review_reply.reviewer.should == reviewer
  end
end

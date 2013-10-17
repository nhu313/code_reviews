require 'spec_helper'

describe ReviewRequest do
  let(:review_request){ReviewRequest.new}

  describe "Completed" do
    let(:review_reply){ReviewReply.new}

    it "is true when there is a reply" do
      review_request.stub(:review_reply).and_return(review_reply)
      review_request.should be_completed
    end

    it "is false when there is no reply" do
      review_request.stub(:review_reply).and_return(nil)
      review_request.should_not be_completed
    end
  end

  describe "Taken" do
    it "is true when there is a reviewer" do
      review_request.reviewer_id = 11
      review_request.should be_taken
    end

    it "is false when there is no reviewer" do
      review_request.reviewer_id = nil
      review_request.should_not be_taken
    end
  end

  describe "Reviewer's name" do
    it "when there is a reviewer" do
      MockUser = Struct.new(:first_name, :last_name)
      review_request.stub(:user).and_return(MockUser.new("first", "last"))
      review_request.reviewer_name.should == "first last"
    end

    it "when there is no reviewer" do
      review_request.reviewer_name.should be_nil
    end
  end

  it "returns requests in default order" do
    user_id = 331
    request1 = ReviewRequest.create({:user_id => user_id, :posted_date => DateTime.now + 10})
    request2 = ReviewRequest.create({:user_id => user_id, :posted_date => DateTime.now})

    requests = ReviewRequest.where({:user_id => user_id})

    requests.last.should == request1

    clean_database(requests)
  end

  def clean_database(review_requests)
    review_requests.each {|r| r.destroy}
  end

end

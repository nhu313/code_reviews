require 'spec_helper'
require 'q/services/factory'

describe ReviewRepliesController do
  let(:review_request_id) {771}

  describe "GET new" do
    let(:review_request_model){Q::Services::Factory.models[:review_request]}

    before (:each) do
      get :new, {:review_request_id => review_request_id}
    end

    it "has a route" do
      response.should be_success
    end

    it "finds the review requests" do
      review_request_model.found_id.should == review_request_id
    end

    it "sets the review request" do
      assigns(:review_request).should == review_request_model.found_data
    end

    it "sets review reply" do
      assigns(:review_reply).should be_a_new(ReviewReply)
    end
  end

  describe "POST create" do
    let(:review_reply_model){Q::Services::Factory.models[:review_reply]}

    before(:each) do
      post :create, {:review_reply => {}, :review_request_id => review_request_id}
    end

    it "redirects to " do
      response.should redirect_to review_path
      # needs to check passed in param
    end

    it "asks service to create new reply" do
      review_reply_model.attributes[:review_request_id].should == review_request_id
    end
  end
end

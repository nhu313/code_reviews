require 'spec_helper'
require 'q/services/factory'
require 'mocks/q/mock_review_request_factory'

describe ReviewsController do
  let(:user_id){121}
  let(:review_request_model){Q::Services::Factory.models[:review_request]}
  let(:review_request) {MockReviewRequestFactory.create(user_id)}

  context "index" do
    before(:each) do
      review_request_model.data = [review_request]
    end

    it "when there is a user in session" do
      request.session[:user_id] = user_id
      get :index
      assigns(:presenter).should_not be_nil
    end

    it "when there is no user in session" do
      get :index
      response.should redirect_to signin_path
    end
  end

  describe "show reviews" do
    let(:review_request_id) {119}
    let(:review_reply) {"reply"}

    before(:each) do
      review_request.review_reply = review_reply
      review_request_model.data = [review_request]
    end

    it "has route" do
      get :show, {:review_request_id => review_request_id}
      response.should be_success
    end

    it "assigns the request" do
      get :show, {:review_request_id => review_request_id}
      assigns(:review_request).should == review_request
    end

    it "assigns the reply" do
      get :show, {:review_request_id => review_request_id}
      assigns(:review_reply).should == review_reply
    end

    it "searches for the request id" do
      get :show, {:review_request_id => review_request_id}
      review_request_model.search_filter[:id].should == review_request_id
    end
  end

  describe "take request" do
    before(:each) do
      request.session[:user_id] = user_id
      review_request_model.data = [review_request_model]
    end

    it "redirect to root path" do
      post :take_request, {:review_request_id => 3}
      response.should redirect_to root_path
    end

    it "asks review reply service to handle request" do
      post :take_request, {:review_request_id => 3}
      review_request_model.attributes.should == {:reviewer_id => user_id}
    end
  end

  describe "skip request" do
    before do
      request.session[:user_id] = user_id
      review_request_model.data = [review_request]
    end

    it "redirect to root path" do
      post :skip_request, {:review_request_id => 3}
      response.should redirect_to root_path
    end

    it "saves skipped history" do
      post :skip_request, {:review_request_id => 3}

      skipped_request_model = Q::Services::Factory.models[:skipped_review_request]
      skipped_request_model.attributes[:user_id].should == user_id
    end
  end
end

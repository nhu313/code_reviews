require 'spec_helper'
require 'mocks/q/mock_review_request_service'
require 'mocks/q/mock_review_reply_service'

describe ReviewsController do
  let(:request_service){Q::MockReviewRequestService.new}
  let(:reply_service) {Q::MockReviewReplyService.new}
  before(:each) do
    @controller.request_service = request_service
    @controller.reply_service = reply_service
  end

  context "index" do
    it "when there is a user in session" do
      request.session[:user_id] = 111
      get :index
      assigns(:presenter).should_not be_nil
    end

    it "when there is no user in session" do
      get :index
      response.should redirect_to signin_url
    end
  end

  describe "show" do
    let(:review){MockReviewReply.new("request")}

    before(:each) do
      reply_service.will_find review
    end
    context "show" do
      it "gets show" do
        get :show, {:id => 11}
        response.should be_success
      end

      it "assigns the request" do
        get :show, {:id => 188}
        assigns(:review_request).should == review.review_request
      end

      it "assigns the reply" do
        get :show, {:id => 188}
        assigns(:review_reply).should == review
      end
    end

    context "edit" do
      it "gets edit" do
        get :edit, {:id => 11}
        response.should be_success
      end

      it "assigns the request" do
        get :edit, {:id => 188}
        assigns(:review_request).should == review.review_request
      end

      it "assigns the reply" do
        get :edit, {:id => 188}
        assigns(:review_reply).should == review
      end
    end

  end

  describe "take request" do
    it "redirect to root path" do
      post :take_request, {:review_request_id => 3}
      response.should redirect_to root_path
    end

    it "asks review reply service to handle request" do
      post :take_request, {:review_request_id => 3}
      reply_service.was told_to :create_review
    end
  end

  describe "create reply" do
    it "renders show" do
      patch :submit_reply, {:id => 1}
      response.should redirect_to :review_reply
    end

    it "asks service to submit reply" do
      patch :submit_reply, {:id => 1}
      reply_service.was told_to :submit_reply
    end
  end
end

class MockReviewReply
  attr_accessor :review_request
  def initialize(review_request)
    @review_request = review_request
  end
end

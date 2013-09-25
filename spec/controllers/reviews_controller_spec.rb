require 'spec_helper'
require 'mocks/q/mock_review_service'

describe ReviewsController do
  let(:review_service){Q::MockReviewService.new}
  let(:reply_service) {}
  before(:each) do
    @controller.review_service = review_service
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

  # describe "GET show" do
  #   it "gets show" do
  #     get :show, {:id => 11}
  #     response.should be_success
  #   end
  #
  #   it "assigns the requested" do
  #     id = 112
  #     review = "fake review"
  #     review_service.will_find review
  #     get :show, {:id => id}
  #     assigns(:review).should == review
  #   end
  # end
  #
  describe "take request" do
    it "redirect to root path" do
      post :take_request, {:review_request_id => 3}
      response.should redirect_to root_path
    end

    it "asks review service to handle request" do
      post :take_request, {:review_request_id => 3}
    end
  end
  #
  # describe "create" do
  #   it "asks service to create" do
  #     review = "review"
  #     review_service.will_create review
  #     post :create, {:review => "some insightful comment"}
  #     assigns(:review).should == review
  #   end
  #
  #   it "shows the review after create" do
  #     post :create, {:review => "ehhh"}
  #     assigns(:review).should render_template :show
  #   end
  # end
end

class MockReplySerivce
  def create_review(user_id, params)

  end
end

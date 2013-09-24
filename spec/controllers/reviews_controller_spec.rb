require 'spec_helper'

describe ReviewsController do
  let(:review_service){MockReviewService.new}

  before(:each) do
    @controller.review_service = review_service
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

  describe "GET show" do
    it "gets show" do
      get :show, {:id => 11}
      response.should be_success
    end

    it "assigns the requested " do
      id = 112
      review = "fake review"
      review_service.will_find review
      get :show, {:id => id}
      assigns(:review).should == review
    end
  end

  describe "GET new" do
    it "gets new" do
      get :new
      response.should be_success
    end

    it "assigns a new request as @request" do
      get :new
      assigns(:review).should be_a_new(Review)
    end
  end

  describe "create" do
    it "asks service to create" do
      review = "review"
      review_service.will_create review
      post :create, {:review => "some insightful comment"}
      assigns(:review).should == review
    end

    it "shows the review after create" do
      post :create, {:review => "ehhh"}
      assigns(:review).should render_template "show"
    end
  end
end

class MockReviewService
  def find(id)
    @review
  end

  def will_find(review)
    @review = review
  end

  def create(user_id, params)
    @review
  end

  def will_create(review)
    @review = review
  end
end

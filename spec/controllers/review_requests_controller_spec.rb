require 'spec_helper'
require 'q/review_request_service'
require 'mocks/q/mock_model'
require 'mocks/q/mock_data'
require 'mocks/q/mock_review_request_service'

describe ReviewRequestsController do
  let(:model) {Q::MockModel.new}
  let(:service) {Q::MockReviewRequestService.new(model)}

  before(:each) do
    @controller.service = service
  end

  describe "GET show" do
    it "gets show" do
      get :show, {:id => 11}
      response.should be_success
    end

    it "assigns the requested request as @request" do
      id = 112
      request = "fake request"
      service.will_find request
      get :show, {:id => id}
      assigns(:review_request).should == request
    end
  end

  describe "GET new" do
    it "gets new" do
      get :new
      response.should be_success
    end

    it "assigns a new request as @request" do
      get :new
      assigns(:review_request).should be_a_new(ReviewRequest)
    end
  end

  describe "POST create" do
    it "post create" do
      post :create, {:review_request => "nothing"}
      response.should be_success
    end

    it "assigns review request" do
      request = "request"
      service.will_create request
      post :create, {:review_request => "nothing"}
      assigns(:review_request).should == request
    end

    it "renders show when form is valid" do
      post :create, {:review_request => "nothing"}
      assigns(:review_request).should render_template :show
    end

    it "returns user to the form when form is invalid" do
      service.will_valid? false
      post :create, {:review_request => "nothing"}
      assigns(:review_request).should render_template :new
    end
  end

end

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

  describe "Getting all requests" do
    it "has a route to get all requests" do
      get :index
      response.should be_success
    end

    it "assigns the review_requests" do
      requests = ["1", "2"]
      service.will_user_requests requests
      get :index
      assigns(:user_requests).should == requests
    end

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

    context "form validation" do
      it "renders show when form is valid" do
        post :create, {:review_request => "nothing"}
        assigns(:review_request).should render_template :show
      end

      it "returns user to the form when form is invalid" do
        service.will_valid? false
        post :create, {:review_request => "nothing"}
        assigns(:review_request).should render_template :new
      end

      context "user partially filled in the form" do
        let(:title){"yellow"}
        let(:url){"url for yellow"}
        let(:description){"description"}
        let(:attributes){{:title => title, :url => url, :description => description}}

        before(:each) do
          service.will_valid? false
          service.will_extract_attributes attributes
          post :create, {:review_request => attributes}
        end

        it "retains the title when form is invalid" do
          assigns(:review_request).title.should == title
        end

        it "retains the url when form is invalid" do
          assigns(:review_request).url.should == url
        end

        it "retains the description when form is invalid" do
          assigns(:review_request).description.should == description
        end

      end
    end
  end

end

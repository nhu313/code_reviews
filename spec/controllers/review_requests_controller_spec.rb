require 'spec_helper'
require 'q/review_request_service'
require 'mocks/q/mock_model'
require 'mocks/q/mock_data'
require 'mocks/q/mock_review_request_service'

describe ReviewRequestsController do
  let(:review_request_id) {113}
  let(:model) {Q::MockModel.new}
  let(:service) {Q::MockReviewRequestService.new(model)}

  before(:each) do
    @controller.service = service
  end

  describe "GET index" do
    before(:each) do
      service.will_have_user_requests [MockReviewRequest.new(1)]
    end

    it "has a route to get all requests" do
      get :index
      response.should be_success
    end

    it "assigns presenter" do
      get :index
      assigns(:presenter).should_not be_nil
    end
  end

  describe "GET show" do
    let(:review_reply){"some reply"}
    let(:review_request){review_request = MockReviewRequest.new(1)
                         review_request.review_reply = review_reply
                         review_request}

    before(:each) do
      service.will_find review_request
    end

    it "gets show" do
      get :show, {:id => review_request_id}
      response.should be_success
    end

    it "assigns the requested request" do
      get :show, {:id => review_request_id}
      assigns(:review_request).should == review_request
    end

    it "assigns the requested request reply when there is one" do
      get :show, {:id => review_request_id}
      assigns(:review_reply).should == review_reply
    end

    it "doesn't assign the requested request reply when there is none" do
      review_request.review_reply = nil
      get :show, {:id => review_request_id}
      assigns(:review_reply).should be_nil
    end

    it "renders show from reply" do
      get :show, {:id => review_request_id}
      response.should render_template 'reviews/show'
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

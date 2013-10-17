require 'spec_helper'
require 'q/services/factory'
require 'mocks/q/services/mock_review_request'

describe ReviewRequestsController do
  let(:review_request_id) {113}
  let(:review_request_model){Q::Services::Factory.models[:review_request]}
  let(:review_request) {MockReviewRequestFactory.create(1)}
  let(:params){{:id => review_request_id}}
  describe "GET index" do
    it "has a route to get all requests" do
      get :index
      response.should be_success
    end

    it "assigns review requests" do
      get :index
      assigns(:review_requests).should_not be_nil
    end
  end

  describe "GET show" do
    it "has route" do
      get :show, params
      response.should be_success
    end

    it "returns review request from database" do
      fake_request = Q::Services::Factory.models[:fake_data]
      review_request_model.data = [fake_request]
      get :show, params
      assigns(:review_request).should == fake_request
    end
  end

  it "gets a new review request" do
    get :new
    assigns(:review_request).should be_a_new(ReviewRequest)
  end

  describe "POST create" do
    let(:service){Q::Services::MockReviewRequest.new}

    before(:each) do
      Q::Services::Factory.stub(:create).and_return(service)
    end

    it "has route" do
      post :create, {:review_request => {}}
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

  context "Archive review request" do
    it "redirect user to review show" do
      post :archive, params
      response.should redirect_to review_request_path(request.parameters)
    end

    it "saves archive request" do
      fake_request = Q::Services::Factory.models[:fake_data]
      review_request_model.data = [fake_request]

      post :archive, params
      fake_request.attributes[:archive].should == true
    end

    it "searches for the request id from parameter" do
      post :archive, params
      review_request_model.search_filter[:id].should == review_request_id
    end
  end
end

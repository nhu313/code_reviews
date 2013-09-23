require 'spec_helper'
require 'q/request_service'
require 'mocks/q/mock_model'
require 'mocks/q/mock_data'

describe RequestsController do
  let(:model) {Q::MockModel.new}
  let(:service) {Q::RequestService.new(model)}
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
      model.data = [Q::MockData.new(id)]

      get :show, {:id => id}
      assigns(:request).should == model.data.first
    end
  end

  describe "GET new" do
    it "gets new" do
      get :new
      response.should be_success
    end

    it "assigns a new request as @request" do
      get :new
      assigns(:request).should be_a_new(Request)
    end
  end
end

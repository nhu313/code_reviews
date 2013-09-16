require 'spec_helper'
require 'mocks/q/mock_user_service'

describe SessionsController do
  it "loads sign in screen" do
    get :signin
    response.should be_success
  end

  context "destroy" do
    it "clear the user id on destroy" do
      request.session[:user_id] = 1
      get :destroy
      request.session[:user_id].should be_nil
    end

    it "redirect to sign in url" do
      get :destroy
      response.should redirect_to signin_url
    end
  end

  context "create" do
    before :each do
      @user_service = Q::MockUserService.new
      @controller = SessionsController.new(@user_service)
    end

    it "asks user service to find the id" do
      get :create
      @user_service.was told_to(:get_user_id)
    end

    it "redirect user to reviews page" do
      get :create
      response.should redirect_to root_url
    end
  end
end

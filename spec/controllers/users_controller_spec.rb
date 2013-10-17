require 'spec_helper'
require 'q/services/factory'

describe UsersController do
  it "gets sign in screen" do
    get :signin
    response.should be_success
  end

  context "destroy" do
    it "clear the user id" do
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
    let(:model){Q::Services::Factory.models[:user]}
    let(:auth){Hash["uid" => "id111", "info" => {}]}

    before(:each) do
      request.env["omniauth.auth"] = auth
      model.data = [model]
    end

    it "gets the user id" do
      get :create
      request.session[:user_id].should == model.id
    end

    it "redirect user to reviews page" do
      get :create
      response.should redirect_to root_url
    end
  end
end

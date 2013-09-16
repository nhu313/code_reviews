require 'spec_helper'

describe ReviewsController do

  context "index" do
    it "loads the index page when there is a user in session" do
      request.session[:user_id] = "user"
      get :index
      response.should be_success
    end

    it "redirect to signin when there is no user in session" do
      get :index
      response.should redirect_to signin_url
    end
  end

end

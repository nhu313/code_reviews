require 'spec_helper'

describe ReviewsController do

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

end

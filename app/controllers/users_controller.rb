require 'q/user_service'
require 'q/db_service'

class UsersController < ApplicationController
  def signin
    render(:layout => "layouts/signin")
  end

  def create
    service = Q::ServiceFactory.create(:user)
    session[:user_id] = service.user_id_for(request.env["omniauth.auth"])
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_url
  end
end

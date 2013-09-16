require 'q/user_service'

class SessionsController < ApplicationController

  def initialize(*user_service)
    @user_service = user_service[0]
  end

  def signin
    render action: "signin"
  end

  def create
    session[:user_id] = user_service.get_user_id(request.env["omniauth.auth"])
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_url
  end

  private
  def user_service
    @user_service ||= Q::UserService.new
  end

end

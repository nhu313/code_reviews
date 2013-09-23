require 'q/user_service'
require 'q/db_service'

class UsersController < ApplicationController
  attr_writer :service

  def signin
    render(:layout => "layouts/signin")
  end

  def create
    session[:user_id] = service.user_id_for(request.env["omniauth.auth"])
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_url
  end

  private
  def service
    @service ||= Q::UserService.new(User)
  end
end

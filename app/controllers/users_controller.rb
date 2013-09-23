require 'q/user_service'
require 'q/db_service'

class UsersController < ApplicationController
  attr_writer :user_service, :db_service

  def signin
    render(:layout => "layouts/signin")
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
    @user_service ||= Q::UserService.new(db_service)
  end

  def db_service
    @db_service ||= Q::DBService.new(User)
  end

end

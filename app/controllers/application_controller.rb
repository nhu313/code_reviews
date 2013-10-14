class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def user_id
    session[:user_id]
  end

  def user_first_name
    session[:user_first_name] ||= User.find_by_id(user_id).first_name
  end
end

class RequestsController < ApplicationController

  def new
    user_id = session[:user_id]
      @user = User.find(user_id)
  end
end

class ReviewsController < ApplicationController

  def index
    user_id = session[:user_id]
    if user_id
      render action: "index"
    else
      redirect_to signin_url
    end
  end
end

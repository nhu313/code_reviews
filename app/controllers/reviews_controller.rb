class ReviewsController < ApplicationController

  def index
    if session[:user_id]
      render action: "index"
    else
      redirect_to signin_url
    end
  end
end

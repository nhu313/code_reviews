class ReviewsController < ApplicationController

  def index
    if session[:user_id]
      @requests = Request.all
      render action: "index"
    else
      redirect_to signin_url
    end
  end
end

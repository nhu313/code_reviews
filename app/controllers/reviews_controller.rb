require 'q/request_service'

class ReviewsController < ApplicationController

  def index
    session[:user_id] = 1
    if session[:user_id]
      @requests = Q::RequestService.new.requests_for(session[:user_id])
      render action: "index"
    else
      redirect_to signin_url
    end
  end
end

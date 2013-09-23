require 'q/request_service'
require 'q/db_service'

class ReviewsController < ApplicationController

  def index
    session[:user_id] = 1
    if user_id
      @requests = request_service.requests_for(user_id)
      render action: "index"
    else
      redirect_to signin_url
    end
  end

  def model
    Request
  end

  private
  def request_service
    Q::RequestService.new(db_service)
  end

end

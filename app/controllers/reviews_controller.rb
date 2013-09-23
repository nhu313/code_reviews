require 'q/request_service'
require 'q/db_service'

class ReviewsController < ApplicationController

  def index
    if user_id
      @presenter = ReviewsPresenter.new(request_service, user_id)
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
    Q::RequestService.new(Request)
  end
end

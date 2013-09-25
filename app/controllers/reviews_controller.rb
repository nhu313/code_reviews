require 'q/review_request_service'
require 'q/review_service'

class ReviewsController < ApplicationController
  attr_writer :review_service

  def index
    if user_id
      @presenter = ReviewsPresenter.new(user_id, request_service, review_service)
      render action: "index"
    else
      redirect_to signin_url
    end
  end

  def take_request
    review_service.create_review(user_id, params["review_request_id"])
    redirect_to root_path
  end

  def show
    @review ||= review_service.find(params["id"].to_i)
  end

  def create
    @review = review_service.create(user_id, params.require(:review))
    render :show
  end

  private
  def request_service
    Q::ReviewRequestService.new(Request)
  end

  def review_service
    @review_service ||= Q::ReviewService.new(Review)
  end
end

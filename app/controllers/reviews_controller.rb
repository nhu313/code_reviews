require 'q/review_request_service'
require 'q/review_service'

class ReviewsController < ApplicationController
  attr_writer :review_service

  def index
    if user_id
      @presenter = ReviewsPresenter.new(request_service, user_id)
      render action: "index"
    else
      redirect_to signin_url
    end
  end

  def new
    @review = Review.new
  end

  def show
    @review ||= review_service.find(params["id"].to_i)
  end

  def create
    @review = review_service.create(user_id, params.require(:review))
    render "show"
  end

  private
  def request_service
    Q::ReviewRequestService.new(Request)
  end

  def review_service
    @review_service ||= Q::ReviewService.new(Review)
  end
end

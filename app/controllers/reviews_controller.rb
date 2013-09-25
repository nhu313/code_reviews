require 'q/review_request_service'
require 'q/review_reply_service'

class ReviewsController < ApplicationController
  attr_writer :review_service, :reply_service

  def index
    if user_id
      @presenter = ReviewsPresenter.new(user_id, review_service)
      render :index
    else
      redirect_to signin_url
    end
  end

  def take_request
    reply_service.create_review(user_id, params["review_request_id"])
    redirect_to root_path
  end

  # def show
  #   @review ||= review_service.find(params["id"].to_i)
  # end
  #
  # def create
  #   @review = review_service.create(user_id, params.require(:review))
  #   render :show
  # end
  #
  # def direct
  #   render :direct
  # end

  private
  def request_service
    Q::ReviewRequestService.new(ReviewRequest)
  end

  def review_service
    @review_service ||= Q::ReviewService.new(user_id, nil, nil)
  end

  def reply_service
    @reply_service ||= Q::ReviewReplyService.new(ReviewReply)
  end
end

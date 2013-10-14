require 'q/reviews'
require 'q/review_request_queue'
require 'q/review_request_service'

class ReviewsController < ApplicationController

  def index
    @presenter = ReviewsPresenter.new(user_id)
  end

  def show
    @review_request = request_service.find(review_request_id)
    @review_reply = @review_request.review_reply
  end

  def take_request
    queue.take_request(review_request_id)
    redirect_to root_path
  end

  def skip_request
    queue.skip_request(review_request_id)
    redirect_to root_path
  end

  private
  def review_request_id
    params[:review_request_id]
  end

  def request_service
    Q::ReviewRequestService.new(user_id, ReviewRequest, SkippedReviewRequest)
  end

  def queue
    Q::ReviewRequestQueue.for(user_id)
  end
end

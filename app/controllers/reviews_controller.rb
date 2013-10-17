require 'q/review_request_queue'
require 'q/services/factory'

class ReviewsController < ApplicationController

  def index
    if user_id
      @presenter = ReviewsPresenter.new(user_id)
    else
      redirect_to signin_path
    end
  end

  def show
    request_service = Q::Services::Factory.create(:review_request, user_id)
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
    params[:review_request_id].to_i
  end

  def queue
    Q::ReviewRequestQueue.for(user_id)
  end
end

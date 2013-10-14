require 'q/reviews'
require 'q/review_request_queue'

class HomepageController < ApplicationController

  def index
    @presenter = HomepagePresenter.new(user_id)
  end

  def show
    @review_request = ReviewRequest.find(review_request_id)
    @review_reply = @review_request.review_reply
  end

  def take_request
    @review_request = ReviewRequest.find(review_request_id)
    @review_request.update_attributes({:reviewer_id => user_id})
    redirect_to root_path
  end

  private
  def review_request_id
    params[:review_request_id]
  end
end

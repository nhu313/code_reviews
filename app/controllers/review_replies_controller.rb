require 'q/services/factory'

class ReviewRepliesController < ApplicationController

  def new
    request_service = Q::Services::Factory.create(:review_request, user_id)
    @review_request = request_service.find(review_request_id)
    @review_reply = ReviewReply.new
  end

  def create
    reply_service = Q::Services::Factory.create(:review_reply, user_id)
    reply_service.create_reply(review_request_id, params[:review_reply])
    redirect_to review_path review_request_id
  end

  private
  def review_request_id
    params[:review_request_id]
  end
end

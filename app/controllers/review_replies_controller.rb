require 'q/review_request_service'
require 'q/review_reply_service'

class ReviewRepliesController < ApplicationController
  attr_writer :request_service, :reply_service

  def new
    @review_request = ReviewRequest.find(params[:review_request_id])
    @review_reply = @review_request.review_reply || ReviewReply.new
  end

  def create
    reply_service.create_reply(review_request_id, params[:review_reply])
    redirect_to review_path review_request_id
  end

  def show
    set_review
  end

  def edit
    set_review
  end

  def submit_reply
    reply_service.submit_reply(review_reply_id, params[:review_reply])
    redirect_to review_reply_url
  end

  def skip_request
    request_service.save_skipped_request(review_request_id)
    redirect_to root_path
  end

  private
  def request_service
    @request_service ||= Q::ReviewRequestService.new(user_id, ReviewRequest, SkippedReviewRequest)
  end

  def reply_service
    @reply_service ||= Q::ReviewReplyService.new(user_id, ReviewReply)
  end

  def set_review
    @review_reply ||= reply_service.find(review_reply_id)
    @review_request = @review_reply.review_request
  end

  def review_reply_id
    params[:id].to_i
  end

  def review_request_id
    params[:review_request_id].to_i
  end
end

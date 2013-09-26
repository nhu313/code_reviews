require 'q/review_request_service'
require 'q/review_reply_service'

class ReviewsController < ApplicationController
  attr_writer :request_service, :reply_service

  def index
    if user_id
      @presenter = ReviewsPresenter.new(request_service, reply_service)
      render :index
    else
      redirect_to signin_url
    end
  end

  def take_request
    reply_service.create_review(params["review_request_id"])
    redirect_to root_path
  end

  def show
    set_current_review
  end

  def edit
    set_current_review
  end

  private
  def request_service
    @request_service ||= Q::ReviewRequestService.new(ReviewRequest, user_id)
  end

  def reply_service
    @reply_service ||= Q::ReviewReplyService.new(ReviewReply, user_id)
  end

  def set_current_review
    @review_reply ||= reply_service.find(params["id"].to_i)
    @review_request = @review_reply.review_request
  end
end

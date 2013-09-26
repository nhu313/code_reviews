require 'q/review_request_service'
require 'q/review_reply_service'

class ReviewsController < ApplicationController
  attr_writer :review_service, :reply_service

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
    @reply ||= reply_service.find(params["id"].to_i)
    @review_request = @reply.review_request
  end

  def edit
    @reply ||= reply_service.find(params["id"].to_i)
    @review_request = @reply.review_request
  end

  private
  def request_service
    Q::ReviewRequestService.new(ReviewRequest, user_id)
  end

  def reply_service
    @reply_service ||= Q::ReviewReplyService.new(ReviewReply, user_id)
  end
end

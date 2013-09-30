require 'q/review_request_service'

class ReviewRequestsController < ApplicationController
  attr_writer :service

  def show
    @review_request = service.find(params["id"].to_i)
  end

  def new
    @review_request = ReviewRequest.new
  end

  def create
    attributes = params[:review_request]
    if service.valid?(attributes)
      @review_request = service.create(user_id, attributes)
      render :show
    else
      flash[:notice] = "Please enter all the required(*) fields."
      @review_request = ReviewRequest.new
      render :new
    end
  end

  private
    def service
      @service ||= Q::ReviewRequestService.new(user_id, ReviewRequest, SkipRequestHistory)
    end
end

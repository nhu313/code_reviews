require 'q/review_request_service'

class ReviewRequestsController < ApplicationController
  attr_writer :service

  def index
    @presenter = ReviewRequestsPresenter.new(service.user_requests)
  end

  def show
    @review_request = service.find(params["id"].to_i)
    @review_reply = @review_request.review_reply if @review_request.completed?
    render 'reviews/show'
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
      @review_request = ReviewRequest.new(service.extract_attributes(attributes))
      render :new
    end
  end

  private
    def service
      @service ||= Q::ReviewRequestService.new(user_id, ReviewRequest, SkipRequestHistory)
    end
end

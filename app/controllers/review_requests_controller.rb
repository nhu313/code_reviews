require 'q/review_request_service'
require 'q/review_requests'

class ReviewRequestsController < ApplicationController
  attr_writer :service

  def index
    @review_requests = Q::ReviewRequests.for(user_id)
  end

  def show
    @review_request = service.find(request_id)
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

  def archive
    service.archive(request_id)
    redirect_to review_request_path(request.parameters)
  end

  private
    def service
      @service ||= Q::ReviewRequestService.new(user_id, ReviewRequest, SkippedReviewRequest)
    end

    def request_id
      params[:id]
    end
end

require 'q/services/factory'
require 'q/review_requests'

class ReviewRequestsController < ApplicationController

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
      @review_request = service.create(attributes)
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
      Q::Services::Factory.create(:review_request, user_id)
    end

    def request_id
      params[:id]
    end
end

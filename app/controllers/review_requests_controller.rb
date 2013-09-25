require 'q/review_request_service'

class ReviewRequestsController < ApplicationController
  attr_writer :service

  def show
    @review_request ||= service.find(params["id"].to_i)
  end

  def new
    @review_request = ReviewRequest.new
  end

  def create
    @review_request = service.create(user_id, params.require(:review_request))
    render "show"
  end

  private
    def service
      @service ||= Q::ReviewRequestService.new(ReviewRequest)
    end
end

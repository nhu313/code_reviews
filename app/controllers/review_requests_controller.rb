require 'q/review_request_service'

class ReviewRequestsController < ApplicationController
  attr_writer :service

  def show
    @request ||= service.find(params["id"].to_i)
  end

  def new
    @request = Request.new
  end

  def create
    @request = service.create(user_id, params.require(:request))
    redirect_to show
  end

  private
    def service
      @service ||= Q::ReviewRequestService.new(Request)
    end
end

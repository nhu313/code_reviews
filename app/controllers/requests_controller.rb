require 'q/request_service'

class RequestsController < ApplicationController
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
      @service ||= Q::RequestService.new(Request)
    end
end

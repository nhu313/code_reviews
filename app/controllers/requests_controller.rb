require 'q/request_service'

class RequestsController < ApplicationController
  attr_writer :service

  def show
    @request = service.find(params["id"].to_i)
  end

  def new
    @request = Request.new
  end

  def create
    @request = service.create(user_id, request_params)
  end

  private
    def request_params
      params.require(:request).permit(:title, :url, :description)
    end

    def service
      @service ||= Q::RequestService.new(Request)
    end
end

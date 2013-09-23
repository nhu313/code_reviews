require 'q/request_service'

class RequestsController < ApplicationController

  def show
    @request = service.find(params["id"].to_i)
  end

  def new
    @request = Request.new
  end

  def create
    @request = service.create(user_id, request_params)

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @request }
      else
        format.html { render action: 'new' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def model
    Request
  end

  private
    def request_params
      params.require(:request).permit(:title, :url, :description)
    end

    def service
      Q::RequestService.new(db_service)
    end

end

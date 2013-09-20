class RequestsController < ApplicationController

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(params[:request])
    redirect_to(root_url, :notice => "Submitted")
  end
end

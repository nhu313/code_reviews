class RequestsController < ApplicationController

  def new
  end

  def create
    redirect_to(root_url, :notice => "Submitted")
  end
end

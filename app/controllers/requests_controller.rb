class RequestsController < ApplicationController
  def new
    @request = Request.new
    # respond_to do |format|
    #   format.js
    #   format.html { render :new  }
  end

  def create
    @request = Request.new(request_params)
  end

  private

  def request_params
    params.permit(:start_time)
  end
end

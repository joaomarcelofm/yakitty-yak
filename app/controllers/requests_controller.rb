class RequestsController < ApplicationController
  def new
    @request = Request.new
    @skills = Skill.pluck(:name) << "Nothing special"
    # respond_to do |format|
    #   format.js
    #   format.html { render :new  }
  end

  def create
    @request = Request.new(request_params)
    @request.user = current_user
    # save the request and redirect
  end

  private

  def request_params
    params.permit(:start_time)
  end
end

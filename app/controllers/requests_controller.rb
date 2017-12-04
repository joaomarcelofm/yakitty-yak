class RequestsController < ApplicationController

  def new
    @request = Request.new
    @skills = Skill.pluck(:name) << "Nothing special"

    respond_to do |format|
      format.js
      format.html { render :new  }
    end
  end

  def create_request
    @request = Request.new(request_params)
    @request.user = current_user
    users = Skill.skill_match(params[:request][:skill])
    @request.receiver = users.sample
    if @request.save
      redirect_to root_path
    else
      render 'new'
    end

  end

  private

  def notification_webhook
    #figure out how to make notifications in slack
  end

  def create_meeting

  end

  def request_params
    params.require(:request).permit(:start_time, :topic, :skill)
  end
end

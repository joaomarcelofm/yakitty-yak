class RequestsController < ApplicationController

  def new
    @request = Request.new
    @skills = Skill.pluck(:name) << "Nothing special"

    # respond_to do |format|
    #   format.js
    #   format.html { render :new  }
    # end
  end

  def create
    @request = Request.new(request_params)
    @request.user = current_user
    skill = Skill.find(params[:request][:skill])
    users = skill.users
    @request.receiver = users.sample

    if @request.save
      redirect_to root_path
    else
      render 'new'
    end

  end

  def accept # RequestsController#accept
    #set the status to 2
    request = Request.find(params[:id])
    request.status = 2
    request.save
    Meeting.create(room_name: 'demo', request: request)
  end

  def reject
    #set the status to 3
    request = Request.find(params[:id])
    request.status = 3
    request.save

  end

  private

  def notification_webhook
    #figure out how to make notifications in slack
  end


  def request_params
    params.require(:request).permit(:start_time, :topic, :skill)
  end
end

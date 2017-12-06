class RequestsController < ApplicationController

  def new
    @request = Request.new
    @skills = Skill.pluck(:name) << "Nothing special"
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

  def accepted # RequestsController#accept
    #set the status to 1
    request = Request.find(params[:id])
    request.status = :accepted
    request.save
    Meeting.create(room_name: 'demo', request: request)
  end

  def rejected
    #set the status to 2
    request = Request.find(params[:id])
    request.status = :rejected
    request.save

  end

  private

  def request_params
    params.require(:request).permit(:start_time, :topic, :skill)
  end
end

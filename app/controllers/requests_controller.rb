class RequestsController < ApplicationController

  def new
    @request = Request.new
    @skills = Skill.pluck(:name) << "Nothing special"
  end

  def create
    @request = Request.new(request_params)
    @request.user = current_user
    unless params[:request][:skill_id].blank?
      skill = Skill.find(params[:request][:skill_id])
      users = skill.users
      candidates = users.reject { |u| u == current_user }
      @request.skill = skill
      @request.receiver = candidates.sample
    end

    if @request.save
      redirect_to dashboard_path
    else
      @skills = Skill.pluck(:name) << "Nothing special"
      render "pages/dashboard"
    end
  end

  def accept # RequestsController#accept
    #set the status to 1
    request = Request.find(params[:id])
    request.status = 1
    request.save
    Meeting.create(room_name: 'demo', request: request)
  end

  def reject
    #set the status to 2
    request = Request.find(params[:id])
    request.status = 2
    request.save

  end

  private

  def request_params
    params.require(:request).permit(:start_time, :topic, :skill_id)
  end
end

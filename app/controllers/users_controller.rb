class UsersController < ApplicationController
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    params_user = set_user_params.except(:skill_ids)

    if params[:user][:skill_ids].present?
      skills = params[:user][:skill_ids].reject(&:empty?)
      @user.skill_ids = skills
      @user.save
    end

    @user.update(params_user)
    redirect_to @user
  end

  private

  def set_user
    @user = current_user
  end

  def set_user_params
    params.require(:user).permit(:name, :location, :occupation, :bio, skill_ids: [:id])
  end
end

class UsersController < ApplicationController
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    @user.update(set_user_params)
    redirect_to @user
  end

  private

  def set_user
    @user = current_user
  end

  def set_user_params
    params.require(:user).permit(:name, :location, :occupation, :bio)
  end
end

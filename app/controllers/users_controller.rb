class UsersController < ApplicationController
  def edit
  end

  def update
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_num, :bio, :photo)
  end
end

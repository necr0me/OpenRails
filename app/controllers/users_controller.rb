class UsersController < ApplicationController
  before_action :correct_user

  def edit
    @user = User.find(params[:id])
    @user_info = @user.user_info
    if @user_info == nil
      @user_info = @user.create_user_info
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(user_info_attributes: [:name,
                                                        :surname,
                                                        :patronymic,
                                                        :passport_code,
                                                        :phone_number])
  end

  def correct_user
    redirect_to root_path unless (logged_in? && current_user.id == params[:id].to_i || current_user_admin?)
  end
end

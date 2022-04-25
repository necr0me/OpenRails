class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    @user_info = @user.user_info ? @user.user_info : @user.create_user_info(discount: Discount.first)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path
    else
      render 'edit'
    end
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
end

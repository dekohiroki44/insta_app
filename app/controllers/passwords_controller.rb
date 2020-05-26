class PasswordsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.authenticate(params[:user][:current_password])
      if  user.update_attributes(user_params)
        flash[:success] = 'パスワード更新しました'
        redirect_to user
      else
        redirect_to edit_password_path(user)
        flash[:danger] = '新しいパスワードが間違ってます'
      end
    else
      redirect_to edit_password_path(user)
      flash[:danger] = '現在のパスワードが間違ってます'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end
end


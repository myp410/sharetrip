class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @owner = @user.groups.find_by(params[:owner_id])
    if @user.update(user_params)
      if @user.is_active == "false"
        @owner.groups.update_all(is_active: "false")
      end
      redirect_to admin_user_path(@user), notice: "ユーザー情報の更新に成功しました"
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :email, :is_active, :profile_image)
  end
end

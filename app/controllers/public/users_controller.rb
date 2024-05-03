class Public::UsersController < ApplicationController
  #before_action :ensure_correct_user, only: %i[edit update unsubscribe withdraw]
  def show
    @posts = Post.all
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_my_page_path(@user), notice: "ユーザー情報の更新に成功しました"
    else
      render 'edit', alert: "ユーザー情報の更新に失敗しました"
    end  
  end  

  def unsubscribe
    @user = User.find(current_user.id)
  end
  
  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    session.destroy
    flash[:notice] = "退会しました。再ログインできません"
    redirect_to root_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :email, :is_active)
  end
  
  #def ensure_correct_user
    #user = User.find(params[:id])
    #return if user == current_user #trueならここで処理を終了
    #redirect_to users_my_page_path(current_user) #falseならこの処理になる
  #end
end

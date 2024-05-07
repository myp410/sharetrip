class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :ensure_correct_user, only: %i[edit update unsubscribe withdraw]
  before_action :ensure_guest_user, only: [:edit]
  before_action :move_to_index, only: %i[edit update unsubscribe withdraw]
  
  def show
    @user = User.find(current_user.id)
    @posts = @user.posts
  end

  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    @user = User.find(current_user.id)
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
    params.require(:user).permit(:name, :introduction, :email, :is_active, :profile_image)
  end
  
  # def ensure_correct_user
  #   user = User.find(params[:id])
  #   return if user == current_user #trueならここで処理を終了
  #   redirect_to users_my_page_path(current_user) #falseならこの処理になる
  # end
  
  def move_to_index
    unless user_signed_in? #userがサインインしてない場合
      redirect_to action: :index
    end
  end
  
  def ensure_guest_user
    @user = User.find(current_user.id)
    if @user.guest_user?
      redirect_to users_mypage_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません"
    end
  end  
end

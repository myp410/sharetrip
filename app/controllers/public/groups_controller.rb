class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:destroy, :update, :permits]
  before_action :group_state, only: [:show, :update]

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      redirect_to groups_path, notice: "グループの作成に成功しました"
    else
      @groups = Group.where(is_active: true).page(params[:page])
      @group = Group.new
      render 'index'
    end
  end

  def index
    @groups = Group.where(is_active: true).page(params[:page])
    @group = Group.new
  end


  def show
    @group = Group.find(params[:id])
    @owner = User.find(@group.owner_id)
    if Room.exists?(group_id: @group.id)
      @room = Room.find_by(group_id: @group.id)
    else
      @room = Room.new
      @room.group = @group
      @room.save
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group),notice: "グループの更新に成功しました"
    else
      @owner = User.find(@group.owner_id)
      if Room.exists?(group_id: @group.id)
        @room = Room.find_by(group_id: @group.id)
      else
        @room = Room.new
        @room.group = @group
        @room.save
      end
      render 'show'
    end
  end
  
  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path, notice: "グループを削除しました"
  end
  
  def permits
    @group = Group.find(params[:id])
    @permits = @group.permits.page(params[:page])
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path, alert: "グループオーナーのみアクセス可能です"
    end
  end

  def group_state
    @group = Group.find(params[:id])
    if !@group.is_active
    # グループがactiveであれば通常の表示をする
      redirect_to groups_path, alert: "このグループは停止されています。運営に問い合わせください"
    end
  end

end

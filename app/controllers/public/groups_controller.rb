class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      redirect_to groups_path, notice: "グループの作成に成功しました"
    else
      render 'new'
    end  
  end

  def index
    @groups = Group.all
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

  def edit
    @group = Group.find(params[:id])
  end
  
  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group),notice: "グループの更新に成功しました"
    else
      render 'edit'
    end  
  end
  
  private
  
  def group_params
    params.require(:group).permit(:name, :introduction)
  end
  
  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end

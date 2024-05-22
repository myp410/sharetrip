class Public::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :block_non_related_users,only: [:show]

  def show
    @group = Group.find(params[:group_id])
    @room = @group.room
    @message = Message.new
    @messages = @room.messages
  end

  def create
    @group = Group.find(params[:group_id])
    @room = Room.new(room_params)
    if @room.save
      redirect_to group_rooms_path(@group)
    else
      render "public/groups/show"
    end
  end

  private

  def room_params
    params.require(:room).permit(:group_id)
  end

  def block_non_related_users
    group = Group.find(params[:group_id])
    unless current_user.groups.include?(group)
      flash[:alert] = "グループメンバー以外はアクセスできません"
      redirect_to group_path(group)
    end
  end


end

class Public::RoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @group = Group.find(params[:group_id])
    @room = @group.room
    @messages = @room.messages
    @message = Message.new
  end

  def create
    @group = Group.find(params[:group_id])
    @room = Room.new(room_params)
    if @room.save
       add_users_to_room(@room, @group)
      redirect_to group_rooms_path(@group), notice: "room success"
    else
      render "public/groups/show"
    end
  end

  private

  def room_params
    params.require(:room).permit(:group_id)
  end
  
  def add_users_to_room(room, group)
    users = group.users
    room.group.users << users
  end
end

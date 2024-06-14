class Public::MessagesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @group = Group.find(params[:group_id])
    @room = @group.room
    if @message = Message.create(params.require(:message).permit(:content, :user_id, :room_id).merge(:user_id => current_user.id))
      redirect_to group_rooms_path(@group)
    else
      render 'public/rooms/show'
    end  
  end
end

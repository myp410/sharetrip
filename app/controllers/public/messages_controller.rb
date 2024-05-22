class Public::MessagesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @group = Group.find(params[:group_id])
    @room = @group.room
    @message = @room.messages.new(message_params)
    @message.user_id = current_user.id
  
    if @message.save
      redirect_to group_rooms_path(@group)
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content, :room_id)
  end
  
end

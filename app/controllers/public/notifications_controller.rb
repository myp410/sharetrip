class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    case notification.notifiable_type
    when "Post"
      redirect_to post_path(notification.notifiable)
    when "PostComment"
      redirect_to post_post_comments_path(notification.notifiable.post)
    when "Relationship"
      redirect_to users_my_page_path(notification.notifiable.follower)
    else
      redirect_to users_my_page_path(notification.notifiable.user)
    end
  end
end

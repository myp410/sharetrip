module Public::NotificationsHelper
  def notification_message(notification)
    time_ago = time_ago_in_words(notification.created_at)

    case notification.notifiable_type
    when "Post"
      "フォローしている#{notification.notifiable.user.name}さんが「#{notification.notifiable.title}」を投稿しました (#{time_ago}前)"
    when "Relationship"
      "#{notification.notifiable.follower.name}さんにフォローされました (#{time_ago}前)"
    else
      "投稿した「#{notification.notifiable.post.title}」が#{notification.notifiable.user.name}さんにいいねされました (#{time_ago}前)"
    end
  end
end

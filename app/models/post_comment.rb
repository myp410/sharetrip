class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications, as: :notifiable, dependent: :destroy
  
  validates :comment, presence: true, length: { maximum: 150 }
  
  def self.looks(word)
    if word == ""
      PostComment.all
    else
      PostComment.where('comment LIKE ?', "%#{word}%")
    end
  end
  
  after_create do
    notifications.create(user_id: post.user.id, post_id: post.id, notifiable_type: "PostComment", notifiable_id: id)
  end
end

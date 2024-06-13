class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  has_many :notifications, as: :notifiable, dependent: :destroy
  
  after_create do
    notifications.create(user_id: followed.id, notifiable_type: "Relationship", notifiable_id: id)
  end
end

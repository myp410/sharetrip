class Group < ApplicationRecord
  has_many :group_users,dependent: :destroy
  has_many :users, through: :group_users
  has_one :room
  
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :introduction, presence: true, length: { maximum: 75 }
  
  def include_user?(user)
    group_users.exists?(user_id: user.id)
  end
end

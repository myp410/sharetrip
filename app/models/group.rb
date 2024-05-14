class Group < ApplicationRecord
  has_many :group_users,dependent: :destroy
  has_many :users, through: :group_users
  
  validates :name, presence: true
  validates :introduction, presence: true
  
  def include_user?(user)
    group_users.exists?(user_id: user.id)
  end
end

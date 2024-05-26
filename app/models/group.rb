class Group < ApplicationRecord
  has_many :group_users,dependent: :destroy
  has_many :users, through: :group_users,dependent: :destroy
  has_one :room,dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :introduction, presence: true, length: { maximum: 75 }

  def include_user?(user)
    group_users.exists?(user_id: user.id)
  end
end

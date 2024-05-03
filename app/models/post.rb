class Post < ApplicationRecord

  belongs_to :user

  validates :title, presence: true
  validates :start_date, presence: true
  validates :finish_date, presence: true

end

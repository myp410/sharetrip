class Post < ApplicationRecord

  belongs_to :user
  has_many :itineraries, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  validates :title, presence: true
  validates :start_date, presence: true
  validates :finish_date, presence: true

end

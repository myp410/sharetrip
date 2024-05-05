class Post < ApplicationRecord

  belongs_to :user
  has_many :itineraries, dependent: :destroy
  accepts_nested_attributes_for :itineraries, allow_destroy: true

  validates :title, presence: true
  validates :start_date, presence: true
  validates :finish_date, presence: true

end

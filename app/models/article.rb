class Article < ApplicationRecord

  belongs_to :itinerary
  
  validates :link, presence: true
  validates :title, presence: true

end

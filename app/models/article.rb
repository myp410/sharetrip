class Article < ApplicationRecord
  belongs_to :itinerary
  
  validates :link, presence: true
end

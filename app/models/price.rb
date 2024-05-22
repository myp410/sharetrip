class Price < ApplicationRecord
  belongs_to :itinerary
  
  validates :price, presence: true
end

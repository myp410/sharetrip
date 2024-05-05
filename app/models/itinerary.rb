class Itinerary < ApplicationRecord
  belongs_to :post
  
  validates :title, presence: true
  validates :start_time, presence: true
  
end

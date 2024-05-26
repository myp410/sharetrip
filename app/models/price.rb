class Price < ApplicationRecord
  belongs_to :itinerary
  
  validates :price, presence: true
  validates :price, format: { with: /\A[0-9０-９]+\z/, message: "を数字で入力して下さい" }
end

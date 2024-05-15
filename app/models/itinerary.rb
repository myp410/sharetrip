class Itinerary < ApplicationRecord
  belongs_to :post
  
  validates :title, presence: true
  validates :start_time, presence: true

  def self.looks(word)
    if word == ""
      Itinerary.all
    else
      Itinerary.where('title LIKE ?', "%#{word}%")
    end
  end  
  
  
end

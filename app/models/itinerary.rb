class Itinerary < ApplicationRecord
  belongs_to :post
  has_many :articles, dependent: :destroy
  has_many :prices, dependent: :destroy


  validates :title, presence: true
  validates :start_time, presence: true
  validates :finish_time, presence: true
  validates :place, presence: true
  validates :body, presence: true
  validates :what_day, presence: true

  def self.looks(word)
    if word == ""
      Itinerary.all
    else
      Itinerary.where('title LIKE ?', "%#{word}%")
    end
  end


end

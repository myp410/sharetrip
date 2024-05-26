class Article < ApplicationRecord

  belongs_to :itinerary
  
  validates :link, presence: true
  validates :link, format: { with: /\A#{URI::regexp(%w(http https))}\z/, message: "をURL形式で入力してください" }
  validates :title, presence: true

end

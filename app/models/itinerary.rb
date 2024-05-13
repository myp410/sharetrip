class Itinerary < ApplicationRecord
  belongs_to :post
  
  validates :title, presence: true
  validates :start_time, presence: true
  validate :validate_what_day
  
  def self.looks(word)
    if word == ""
      Itinerary.all
    else
      Itinerary.where('title LIKE ?', "%#{word}%")
    end
  end  
  
  private

  def validate_what_day
    return if post.nil? || what_day.nil? || post.start_date.nil? || post.finish_date.nil?

    duration = (post.finish_date - post.start_date).to_i + 1
    return if what_day.between?(1, duration)

    errors.add(:what_day, "は期間内の値を入力してください")
  end
  
end

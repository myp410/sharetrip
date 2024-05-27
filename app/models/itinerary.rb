class Itinerary < ApplicationRecord
  belongs_to :post
  has_many :articles, dependent: :destroy
  has_many :prices, dependent: :destroy


  validates :title, presence: true
  validates :start_time, presence: true
  validates :what_day, presence: true
  validate :start_finish_check

#終了時間が開始時間より後に来ないようにバリデーション
  def start_finish_check
    errors.add(:finish_time, "は開始時刻より遅い時間を選択してください") if self.start_time > self.finish_time
  end


  def self.looks(word)
    if word == ""
      Itinerary.all
    else
      Itinerary.where('title LIKE ?', "%#{word}%")
    end
  end


end

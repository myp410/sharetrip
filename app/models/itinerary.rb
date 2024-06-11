class Itinerary < ApplicationRecord
  belongs_to :post
  has_many :articles, dependent: :destroy
  has_many :prices, dependent: :destroy


  validates :title, presence: true
  validates :start_time, presence: true
  validates :what_day, presence: true
  validates :traffic_method, presence: true
  validate :start_finish_check

  before_validation :set_datetimes

#終了時間が開始時間より後に来ないようにバリデーション
  def start_finish_check
    if start_time.present? && finish_time.present?
      errors.add(:finish_time, "は開始時刻より遅い時間を選択してください") if self.start_time > self.finish_time
    end
  end


  def self.looks(word)
    if word == ""
      Itinerary.all
    else
      Itinerary.where('title LIKE ?', "%#{word}%")
    end
  end
  
  def traffic_time_display
    '約 ' + traffic_time_hour.to_s + ' : ' + traffic_time_min.to_s
  end

  enum traffic_method: {no: 0, car: 1, bus: 2,  train: 3, plane: 4, walk: 5 }

  private

  def set_datetimes
    start_date = self.post.start_date.to_s
    start_time = self.start_time.to_s.split[1]
    finish_time = self.finish_time.to_s.split[1]
    past_day = self.what_day - 1
    self.start_time = Time.zone.parse("#{start_date} #{start_time}").since(past_day.day)
    self.finish_time = Time.zone.parse("#{start_date} #{finish_time}").since(past_day.day)
  end

  
end

class Post < ApplicationRecord

  belongs_to :user
  has_many :itineraries, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags #投稿画面で表示したいから中間テーブル経由でのこの記載を

  validates :title, presence: true
  validates :start_date, presence: true
  validates :finish_date, presence: true
  
  def self.looks(word)
    if word == ""
      Post.all
    else
      Post.where('title LIKE ?', "%#{word}%")
    end
  end  
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end

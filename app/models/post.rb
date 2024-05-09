class Post < ApplicationRecord

  belongs_to :user
  has_many :itineraries, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

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

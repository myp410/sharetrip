class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :comment, presence: true
  
  def self.looks(word)
    if word == ""
      PostComment.all
    else
      PostComment.where('comment LIKE ?', "%#{word}%")
    end
  end
end

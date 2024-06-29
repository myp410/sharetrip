class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates :name, presence: true

  def self.looks(word)
    if word == ""
      Tag.all
    else
      Tag.where("name LIKE ?", "%#{word}%")
    end
  end
end

class Post < ApplicationRecord

  belongs_to :user
  has_many :itineraries, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy #投稿画面で表示したいから中間テーブル経由でのこの記載をする
  has_many :items, dependent: :destroy

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
  
  def save_tags(tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    # 新しいタグを保存
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name:new_name)
      self.tags << tag
    end
  end
  
  
  def update_tags(latest_tags)
    if self.tags.empty? #既存のタグがない場合、追加のみ行う 初回ではタグ登録をしていなく、２回目でタグ登録をした
      latest_tags.each do |latest_tag|
        self.tags.find_or_create_by(name: latest_tag)
      end
    elsif latest_tags.empty? #更新対象のタグがなかったら既存のタグを全て削除　元々タグを登録していて、からで更新した時
      self.tags.each do |tag|
        self.tags.delete(tag)
      end
    else #既存のタグも更新対象のタグもある場合、差分更新
      current_tags = self.tags.pluck(:name)
      old_tags = current_tags - latest_tags #左側を基準に考える b-abc = ""
      new_tags = latest_tags - current_tags #abc-b=ac
      
      new_tags.each do |new_tag|
        self.tags.find_or_create_by(name: new_tag)
      end 
      
      old_tags.each do |old_tag|
        tag = self.tags.find_by(name: old_tag)
        self.tags.delete(tag) if tag.present?
      end  
      
    end  
  end

  enum status: { published: 0, draft: 1,  unpublished: 2 }


end

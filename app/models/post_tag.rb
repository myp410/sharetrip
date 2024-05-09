class PostTag < ApplicationRecord
  belongs_to :tag
  belongs_to :post
  
  def save_tags(tags)
    tags.each do |new_tags|
      self.tags.find_or_create_by(name: new_tags)
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
      new_tags = latest_tags - current_tags #abc-b=a
      
      old_tags.each do |old_tag|
        tag = self.tags.find_by(name: old_tag)
        self.tags.delete(tag) if tag.present?
      end  
      
      new_tags.each do |new_tag|
        self.tags.find_or_create_by(name: new_tag)
      end  
    end  
  end
end

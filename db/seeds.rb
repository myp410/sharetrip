# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'active_support/all'

Admin.create!(
   email: 'admin@admin',
   password: 'password'
)

5.times do |n|
  User.create!(
    name: "令和#{n + 1}",
    email: "sample#{n + 1}@example.com",
    introduction: "test#{n + 1}",
    password: "password",
    is_active: "true",
  )
end

#postデータ作成
10.times do |n|
  start_start_day = Date.new(2024, 8, 15)
  start_end_day = Date.new(2027, 8, 31)
  end_start_day = Date.new(2024, 8, 15)
  end_end_day = Date.new(2027, 8, 31)

  start_date = Random.rand(start_start_day..start_end_day)
  finish_date = Random.rand(end_start_day..end_end_day)

  # start_dateがfinish_dateよりも遅い場合は再生成する
  while start_date >= finish_date || (start_date + 1.month) < finish_date
    start_date = Random.rand(start_start_day..start_end_day)
    finish_date = Random.rand(end_start_day..end_end_day)
  end

  Post.create(
    user_id: Random.rand(1..5),
    title: "test#{n + 1}",
    start_date: start_date,
    finish_date: finish_date,
    body: "test_body#{n + 1}",
    status: Random.rand(0..2)
  )
end

#itineraryデータ作成
20.times do |n|
  start_time = Time.new(2012, 1, 1, Random.rand(24), Random.rand(60), Random.rand(60))
  finish_time = Time.new(2012, 1, 1, Random.rand(24), Random.rand(60), Random.rand(60))
  
  while start_time >= finish_time
    start_time = Time.new(2012, 1, 1, Random.rand(24), Random.rand(60), Random.rand(60))
　　finish_time = Time.new(2012, 1, 1, Random.rand(24), Random.rand(60), Random.rand(60))
  end
  
  Itinerary.create(
    post_id: Random.rand(1..5) ,
    title: "test#{n + 1}",
    place: "test_place#{n + 1}",
    start_time: start_time,
    finish_time: finish_time,
    body: "test_body#{n + 1}"
  )
end

#tagデータ作成
Tag.create!(name: "国内")
Tag.create!(name: "海外")
Tag.create!(name: "市内観光")
Tag.create!(name: "自然満喫")

# post_tagデータ
# Tagデータの作成
tags = Tag.all
# 投稿ごとにタグを設定する
10.times do |n|
  # タグをランダムに選択するための配列を用意する
  available_tags = tags.to_a
  # 最低一つのタグを選択する
  tag = available_tags.sample
  PostTag.find_or_create_by!(tag_id: tag.id, post_id: Random.rand(1..10))

end


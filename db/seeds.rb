# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'active_support/all'

#userモデル
Admin.create!(
   email: 'admin@admin',
   password: 'password'
)

User.create!(
  user_id: 6,
  name: "jade",
  email: "sample6@example.com",
  introduction: "関西在住の旅行好きです。",
  password: "password",
  is_active: "true"
)

User.create!(
  user_id: 7,
  name: "ruby",
  email: "sample7@example.com",
  introduction: "海外旅行大好き！",
  password: "password",
  is_active: "true"
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
posts_data = [
  {
    post_id: 1,
    user_id: 6,
    title: "フィリピン",
    body: "自然を巡る家族旅行",
    status: 0,
    start_date: Date.new(2025, 4, 8),
    finish_date: Date.new(2025, 4, 11),
    tags: ["自然", "フィリピン"]
  },
  {
    post_id: 2,
    user_id: 6,
    title: "ハワイ",
    body: "ビーチでのんびりリラックス",
    status: 1,
    start_date: Date.new(2025, 5, 10),
    finish_date: Date.new(2025, 5, 13),
    tags: ["ビーチ", "ハワイ"]
  },
  {
    post_id: 3,
    user_id: 6,
    title: "北海道",
    body: "スノボメインの旅行",
    status: 2,
    start_date: Date.new(2025, 2, 1),
    finish_date: Date.new(2025, 2, 3),
    tags: ["スノボ", "北海道"]
  },  
  {
    post_id: 4,
    user_id: 7,
    title: "オーストラリア",
    body: "世界遺産のグレートバリアリーフをみに行く！",
    status: 0,
    start_date: Date.new(2025, 9, 11),
    finish_date: Date.new(2025, 9, 14),
    tags: ["ケアンズ", "オーストラリア"]
  },
  {
    post_id: 5,
    user_id: 7,
    title: "韓国",
    body: "韓国料理爆食旅",
    status: 1,
    start_date: Date.new(2025, 5, 17),
    finish_date: Date.new(2025, 5, 20),
    tags: ["韓国", "韓国料理"]
  },
  {
    post_id: 6,
    user_id: 7,
    title: "福岡",
    body: "福岡グルメ旅",
    status: 2,
    start_date: Date.new(2025, 10, 1),
    finish_date: Date.new(2025, 10, 3),
    tags: ["福岡", "グルメ"]
  },  
]

posts_data.each do |post_data|
  tags = post_data.delete(:tags) # タグのデータを一時的に取り出す
  post = Post.create!(post_data.merge(created_at: Time.now, updated_at: Time.now))
  tags.each do |tag_name|
    tag = Tag.find_or_create_by(name: tag_name)
    post.tags << tag
  end
end

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
itineraries = [
  { post_id: 1, title: "出発", body: "関空からマクタン空港へ", start_time: DateTime.parse("2025-04-08 20:00:00"), finish_time: DateTime.parse("025-04-09 7:00:00"), place: "関西空港", what_day: 1 },
  { post_id: 1, title: "ホテル朝食", body: "ホテルビュッフェ", start_time: DateTime.parse("2025-04-09 7:00:00"), finish_time: DateTime.parse("025-04-09 9:00:00"), place: "マクタン島ホテル", what_day: 2 },
  { post_id: 1, title: "マクタン島ツアー", body: "マクタン島周遊ツアー。ショッピングセンターやギター工場まで", start_time: DateTime.parse("025-04-09 9:00:00"), finish_time: DateTime.parse("025-04-09 14:00:00"), place: "マクタン島", what_day: 2 },
  { post_id: 1, title: "ホテルのプール", body: "プールで遊びながらプールサイドバーでお酒", start_time: DateTime.parse("025-04-09 14:00:00"), finish_time: DateTime.parse("025-04-09 17:00:00"), place: "マクタン島ホテル", what_day: 2 },
  { post_id: 1, title: "ディナー", body: "現地で有名なステーキ屋へ！日本人オーナー", start_time: DateTime.parse("025-04-09 18:00:00"), finish_time: DateTime.parse("025-04-09 20:00:00"), place: "マクタン島", what_day: 2 },
  { post_id: 2, title: "オスロブ", body: "ジンベイザメツアー", start_time: DateTime.parse("2025-04-09 2:00:00"), finish_time: DateTime.parse("2022-01-02 16:00:00"), place: "場所2", what_day: 2 },
  { post_id: 3, title: "タイトル3", body: "本文3", start_time: DateTime.parse("2022-01-03 18:00:00"), finish_time: DateTime.parse("2022-01-03 20:00:00"), place: "場所3", what_day: 3 }
]

# itinerariesを作成する
itineraries.each do |itinerary|
  Itinerary.create(itinerary)
end



20.times do |n|
  start_time = Time.new(2012, 1, 1, Random.rand(24), Random.rand(60), Random.rand(60))
  finish_time = Time.new(2012, 1, 1, Random.rand(24), Random.rand(60), Random.rand(60))

  while start_time >= finish_time
    start_time = Time.new(2012, 1, 1, Random.rand(24), Random.rand(60), Random.rand(60))
　　finish_time = Time.new(2012, 1, 1, Random.rand(24), Random.rand(60), Random.rand(60))
  end

  post = Post.find(Random.rand(1..5))
  duration = (post.finish_date - post.start_date).to_i + 1
  what_day = Random.rand(1..duration)

  Itinerary.create(
    post_id: post.id,
    title: "test#{n + 1}",
    place: "test_place#{n + 1}",
    start_time: start_time,
    finish_time: finish_time,
    body: "test_body#{n + 1}",
    what_day: what_day
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


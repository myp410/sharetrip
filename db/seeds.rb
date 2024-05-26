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

5.times do |n|
  User.create!(
    name: "令和#{n + 1}",
    email: "sample#{n + 1}@example.com",
    introduction: "test#{n + 1}",
    password: "password",
    is_active: "true",
  )
end

User.create!(
  id: 6,
  name: "jade",
  email: "sample6@example.com",
  introduction: "関西在住の旅行好きです。",
  password: "password",
  is_active: "true"
)

User.create!(
  id: 7,
  name: "ruby",
  email: "sample7@example.com",
  introduction: "海外旅行大好き！",
  password: "password",
  is_active: "true"
)



#postデータ作成
posts_data = [
  {
    id: 1,
    user_id: 6,
    title: "フィリピン",
    body: "自然を巡る家族旅行",
    status: 0,
    start_date: Date.new(2025, 4, 8),
    finish_date: Date.new(2025, 4, 11),
    tags: ["自然", "フィリピン"]
  },
  {
    id: 2,
    user_id: 6,
    title: "ハワイ",
    body: "ビーチでのんびりリラックス",
    status: 1,
    start_date: Date.new(2025, 5, 10),
    finish_date: Date.new(2025, 5, 13),
    tags: ["ビーチ", "ハワイ"]
  },
  {
    id: 3,
    user_id: 6,
    title: "北海道",
    body: "スノボメインの旅行",
    status: 2,
    start_date: Date.new(2025, 2, 1),
    finish_date: Date.new(2025, 2, 3),
    tags: ["スノボ", "北海道"]
  },  
  {
    id: 4,
    user_id: 7,
    title: "オーストラリア",
    body: "世界遺産のグレートバリアリーフをみに行く！",
    status: 0,
    start_date: Date.new(2025, 9, 11),
    finish_date: Date.new(2025, 9, 14),
    tags: ["ケアンズ", "オーストラリア"]
  },
  {
    id: 5,
    user_id: 7,
    title: "韓国",
    body: "韓国料理爆食旅",
    status: 1,
    start_date: Date.new(2025, 5, 17),
    finish_date: Date.new(2025, 5, 20),
    tags: ["韓国", "韓国料理"]
  },
  {
    id: 6,
    user_id: 7,
    title: "福岡",
    body: "福岡グルメ旅",
    status: 2,
    start_date: Date.new(2025, 10, 1),
    finish_date: Date.new(2025, 10, 2),
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
  { post_id: 1, title: "出発", body: "関空からマクタン空港へ", start_time: DateTime.parse("2025-04-08 20:00:00+09:00"), finish_time: DateTime.parse("2025-04-09 7:00:00+09:00"), place: "関西空港", what_day: 1 },
  { post_id: 1, title: "ホテル朝食", body: "ホテルビュッフェ", start_time: DateTime.parse("2025-04-09 7:00:00+09:00"), finish_time: DateTime.parse("2025-04-09 9:00:00+09:00"), place: "マクタン島ホテル", what_day: 2 },
  { post_id: 1, title: "マクタン島ツアー", body: "マクタン島周遊ツアー。ショッピングセンターやギター工場まで", start_time: DateTime.parse("2025-04-09 9:00:00+09:00"), finish_time: DateTime.parse("2025-04-09 14:00:00+09:00"), place: "マクタン島", what_day: 2 },
  { post_id: 1, title: "ホテルのプール", body: "プールで遊びながらプールサイドバーでお酒", start_time: DateTime.parse("2025-04-09 14:00:00+09:00"), finish_time: DateTime.parse("2025-04-09 17:00:00+09:00"), place: "マクタン島ホテル", what_day: 2 },
  { post_id: 1, title: "ディナー", body: "現地で有名なステーキ屋へ！日本人オーナー", start_time: DateTime.parse("2025-04-09 18:00:00+09:00"), finish_time: DateTime.parse("2025-04-09 20:00:00+09:00"), place: "マクタン島", what_day: 2 },
  { post_id: 1, title: "オスロブ", body: "ジンベイザメツアー", start_time: DateTime.parse("2025-04-10 2:00:00+09:00"), finish_time: DateTime.parse("2025-04-10 10:00:00+09:00"), place: "セブ島、オスロブ", what_day: 3 },
  { post_id: 1, title: "スミロン", body: "", start_time: DateTime.parse("2025-04-10 10:00:00+09:00"), finish_time: DateTime.parse("2025-04-10 12:00:00+09:00"), place: "セブ島、スミロン島", what_day: 3 },
  { post_id: 1, title: "カワサン滝", body: "キャニオニング", start_time: DateTime.parse("2025-04-10 12:00:00+09:00"), finish_time: DateTime.parse("2025-04-10 15:00:00+09:00"), place: "セブ島、カワサン滝", what_day: 3 },
  { post_id: 1, title: "ウミガメ", body: "シュノーケリング", start_time: DateTime.parse("2025-04-10 15:00:00+09:00"), finish_time: DateTime.parse("2025-04-10 19:00:00+09:00"), place: "セブ島、モアルボアル", what_day: 3 },
  { post_id: 1, title: "帰国", body: "", start_time: DateTime.parse("2025-04-10 20:00:00+09:00"), finish_time: DateTime.parse("2025-04-11 6:00:00+09:00"), place: "", what_day: 4 },
  
  { post_id: 2, title: "朝食ビュッフェ", body: "ホテル", start_time: DateTime.parse("2025-05-10 08:00:00+09:00"), finish_time: DateTime.parse("2025-05-10 10:00:00+09:00"), place: "ホテル", what_day: 1 },
  { post_id: 2, title: "ビーチ", body: "", start_time: DateTime.parse("2025-05-10 11:00:00+09:00"), finish_time: DateTime.parse("2025-05-10 15:00:00+09:00"), place: "ビーチ", what_day: 1 },
  { post_id: 2, title: "ショッピング", body: "ショッピングセンターで買い物", start_time: DateTime.parse("2025-05-11 10:00:00+09:00"), finish_time: DateTime.parse("2025-05-11 14:00:00+09:00"), place: "ショッピングセンター", what_day: 2 },
  { post_id: 2, title: "ステーキディナー", body: "豪華な晩酌", start_time: DateTime.parse("2025-05-11 18:00:00+09:00"), finish_time: DateTime.parse("2025-05-11 21:00:00+09:00"), place: "ステーキハウス", what_day: 2 },
  { post_id: 2, title: "山登り", body: "", start_time: DateTime.parse("2025-05-12 10:00:00+09:00"), finish_time: DateTime.parse("2025-05-12 20:00:00+09:00"), place: "ハイキング", what_day: 3 },
  { post_id: 2, title: "飛行機", body: "", start_time: DateTime.parse("2025-05-13 8:00:00+09:00"), finish_time: DateTime.parse("2025-05-13 10:00:00+09:00"), place: "帰国", what_day: 4 },
  
  { post_id: 3, title: "キロロリゾート", body: "滑りまくり", start_time: DateTime.parse("2025-02-01 10:00:00+09:00"), finish_time: DateTime.parse("2025-02-01 18:00:00+09:00"), place: "キロロリゾート", what_day: 1 },
  { post_id: 3, title: "ススキノ飲み歩き", body: "美味しい海鮮居酒屋巡り", start_time: DateTime.parse("2025-02-01 19:00:00+09:00"), finish_time: DateTime.parse("2025-02-01 22:00:00+09:00"), place: "ススキノ", what_day: 1 },
  { post_id: 3, title: "キロロリゾート", body: "滑りまくり", start_time: DateTime.parse("2025-02-02 10:00:00+09:00"), finish_time: DateTime.parse("2025-02-02 18:00:00+09:00"), place: "キロロリゾート", what_day: 2 },
  { post_id: 3, title: "ディナー", body: "ジンギスカン食べ放題", start_time: DateTime.parse("2025-02-02 19:00:00+09:00"), finish_time: DateTime.parse("2025-02-02 22:00:00+09:00"), place: "サッポロビール園", what_day: 2 },
  { post_id: 3, title: "市内観光", body: "札幌市内観光、市場とか行きたい", start_time: DateTime.parse("2025-02-03 10:00:00+09:00"), finish_time: DateTime.parse("2025-02-03 15:00:00+09:00"), place: "札幌市", what_day: 3 },
  { post_id: 3, title: "飛行機", body: "", start_time: DateTime.parse("2025-02-03 15:00:00+09:00"), finish_time: DateTime.parse("2025-02-03 17:00:00+09:00"), place: "帰国", what_day: 3 },
  
  { post_id: 4, title: "出発", body: "関空からケアンズ空港へ", start_time: DateTime.parse("2025-09-11 20:00:00+09:00"), finish_time: DateTime.parse("2025-09-12 7:00:00+09:00"), place: "関西空港", what_day: 1 },
  { post_id: 4, title: "市内ぶらり", body: "昼ごはんも済ませる", start_time: DateTime.parse("2025-09-12 7:00:00+09:00"), finish_time: DateTime.parse("2025-09-12 9:00:00+09:00"), place: "市内", what_day: 2 },
  { post_id: 4, title: "動物園", body: "カンガルー、ワニ、熱帯の鳥みれる", start_time: DateTime.parse("2025-09-12 9:00:00+09:00"), finish_time: DateTime.parse("2025-04-09 14:00:00+09:00"), place: "動物園", what_day: 2 },
  { post_id: 4, title: "ディナー", body: "ホテルのディナー弾き語りある", start_time: DateTime.parse("2025-09-12 18:00:00+09:00"), finish_time: DateTime.parse("2025-09-12 20:00:00+09:00"), place: "ホテル", what_day: 2 },
  { post_id: 4, title: "グリーン島", body: "グレートバリアリーフ", start_time: DateTime.parse("2025-09-13 8:00:00+09:00"), finish_time: DateTime.parse("2025-09-13 17:00:00+09:00"), place: "グリーン島", what_day: 3 },
  { post_id: 4, title: "ナイトマーケット", body: "", start_time: DateTime.parse("2025-09-10 18:00:00+09:00"), finish_time: DateTime.parse("2025-09-13 22:00:00+09:00"), place: "ナイトマーケット", what_day: 3 },
  { post_id: 4, title: "ショッピング", body: "アウトレットでショッピング", start_time: DateTime.parse("2025-09-14 10:00:00+09:00"), finish_time: DateTime.parse("2025-09-14 15:00:00+09:00"), place: "アウトレット", what_day: 4 },
  { post_id: 4, title: "市内ぶらり", body: "市内ぶらり", start_time: DateTime.parse("2025-09-14 15:00:00+09:00"), finish_time: DateTime.parse("2025-09-14 19:00:00+09:00"), place: "市内", what_day: 4 },
  { post_id: 4, title: "帰国", body: "", start_time: DateTime.parse("2025-09-14 20:00:00+09:00"), finish_time: DateTime.parse("2025-09-14 6:00:00+09:00"), place: "", what_day: 4 },
  
  { post_id: 5, title: "出発", body: "関空から仁川空港へ", start_time: DateTime.parse("2025-05-17 20:00:00+09:00"), finish_time: DateTime.parse("2025-05-17 22:00:00+09:00"), place: "関西空港", what_day: 1 },
  { post_id: 5, title: "朝カフェ", body: "ギリシャヨーグルト有名。ジブリの世界観", start_time: DateTime.parse("2025-05-17 7:00:00+09:00"), finish_time: DateTime.parse("2025-05-17 9:00:00+09:00"), place: "ドトリガーデン", what_day: 2 },
  { post_id: 5, title: "チマチョゴリ体験", body: "チマチョゴリ着てみる", start_time: DateTime.parse("2025-05-17 9:00:00+09:00"), finish_time: DateTime.parse("2025-05-17 12:00:00+09:00"), place: "きょんぼっくん", what_day: 2 },
  { post_id: 5, title: "市場食べ歩き", body: "キンパ、トッポギ、クァベギ", start_time: DateTime.parse("2025-05-17 12:00:00+09:00"), finish_time: DateTime.parse("2025-05-17 15:00:00+09:00"), place: "カンジャンシジャン", what_day: 2 },
  { post_id: 5, title: "明洞ぶらり", body: "ジェントルモンスターの店舗行きたい", start_time: DateTime.parse("2025-05-17 16:00:00+09:00"), finish_time: DateTime.parse("2025-05-17 20:00:00+09:00"), place: "明洞", what_day: 2 },
  { post_id: 5, title: "ディナー", body: "", start_time: DateTime.parse("2025-05-17 20:00:00+09:00"), finish_time: DateTime.parse("2025-05-17 22:00:00+09:00"), place: "ハムチョカンジャンケジャン", what_day: 2 },
  { post_id: 5, title: "タッカンマリ", body: "初めてのタッカンマリ、思ったより並んでいた", start_time: DateTime.parse("2025-05-18 10:00:00+09:00"), finish_time: DateTime.parse("2025-05-18 12:00:00+09:00"), place: "トンデムン", what_day: 3 },
  { post_id: 5, title: "ソンスぶらり", body: "ショッピング。若者の街", start_time: DateTime.parse("2025-05-18 13:00:00+09:00"), finish_time: DateTime.parse("2025-05-18 17:00:00+09:00"), place: "聖水", what_day: 3 },
  { post_id: 5, title: "サムギョプサル", body: "念願のサムギョプサル", start_time: DateTime.parse("2025-05-18 19:00:00+09:00"), finish_time: DateTime.parse("2025-05-18 20:00:00+09:00"), place: "黄金食堂", what_day: 3 },
  { post_id: 5, title: "ホテル晩酌", body: "韓国チキン大量買いする", start_time: DateTime.parse("2025-05-18 22:00:00+09:00"), finish_time: DateTime.parse("2025-05-18 23:00:00+09:00"), place: "聖水", what_day: 3 },
  { post_id: 5, title: "帰国", body: "", start_time: DateTime.parse("2025-05-19 15:00:00+09:00"), finish_time: DateTime.parse("2025-05-19 17:00:00+09:00"), place: "聖水", what_day: 4 },
  
  { post_id: 6, title: "ランチ", body: "もつ鍋", start_time: DateTime.parse("2025-10-01 12:00:00+09:00"), finish_time: DateTime.parse("2025-10-01 15:00:00+09:00"), place: "やまや", what_day: 1 },
  { post_id: 6, title: "飲み歩き", body: "屋台はしご", start_time: DateTime.parse("2025-10-01 18:00:00+09:00"), finish_time: DateTime.parse("2025-10-01 22:00:00+09:00"), place: "中洲", what_day: 1 },
  { post_id: 6, title: "ランチ", body: "鉄鍋餃子", start_time: DateTime.parse("2025-10-02 12:00:00+09:00"), finish_time: DateTime.parse("2025-10-02 15:00:00+09:00"), place: "鉄鍋餃子", what_day: 2 },
  { post_id: 6, title: "ラーメン", body: "とんこつラーメン", start_time: DateTime.parse("2025-10-02 18:00:00+09:00"), finish_time: DateTime.parse("2025-10-02 22:00:00+09:00"), place: "とんこつラーメン", what_day: 2 },
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

  post = Post.find(Random.rand(7..16))
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
tag_post = Post.find(Random.rand(7..16))
# 投稿ごとにタグを設定する
10.times do |n|
  tag_post = Post.find(Random.rand(7..16))
  # タグをランダムに選択するための配列を用意する
  available_tags = tags.shuffle
  # 最大3つのタグを選択する
  selected_tags = available_tags.sample(3)
  selected_tags.each do |tag|
    PostTag.find_or_create_by!(tag_id: tag.id, post_id: tag_post.id )
  end
end

#groupデータ
Group.create!(
  name: "国内旅行大好き",
  introduction: "旅行好きの中でも国内旅行が特に好きな方はぜひ",
  owner_id: 6,
  is_active: "true"
  )

GroupUser.create!(
  user_id: 6,
  group_id: 1
  )
  
Group.create!(
  name: "韓国旅行",
  introduction: "今度韓国旅行しますのでおすすめ教えてください",
  owner_id: 7,
  is_active: "true"
  )  
  
GroupUser.create!(
  user_id: 7,
  group_id: 2
  )  
  
  
#コメントデータ  
user = User.find(Random.rand(1..7))
post = Post.find(Random.rand(1..16))

30.times do |n|
  PostComment.create!(
    comment: "すごく参考になりました！",
    user_id: user.id,
    post_id: post.id,
  )
end
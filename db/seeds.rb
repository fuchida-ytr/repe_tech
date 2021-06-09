# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User
user = User.new(
  name: 'fuchida',
  email: 'sample@gmail.com',
  password: '111111'
)
user.save!

# RSpec courses-chapters-sections
rspec_id = '1001'
Course.create!(
  id: rspec_id,
  title: 'RSpec',
  caption: 'Rubyコードをテストするためにプログラミング言語Rubyで書かれたコンピュータードメイン固有の言語テストツールです。',
  image: File.open("./app/assets/images/rspec.png")
)

## RSpec chapters
rspec_c1_id = '10001'
[
  [rspec_c1_id, 'イントロダクション'],
  ['10002', 'RSpecのセットアップ'],
  ['10003', 'モデルスペック'],
].each do |id, title|
  Chapter.create!(
    { id: id, title: title, course_id: rspec_id}
  )
end

### RSpec rspec_c1_id:イントロダクション sections
[
  ['10001', '効果的なテストの書き方の学習フレームワーク'],
  ['10002', 'テストの原則'],
  ['10003', 'なぜビューはテストしないのか?'],
].each do |id, title|
  Section.create!(
    { id: id, title: title, content: '', chapter_id: rspec_c1_id}
  )
end

# Rails courses-chapters-sections
rails_id = '2001'
Course.create!(
  id: rails_id,
  title: 'Ruby on Rails',
  caption: '、オープンソースのWebアプリケーションフレームワークである。',
  image: File.open("./app/assets/images/rails.png")
)

## RSpec chapters
rails_c1_id = '20001'
[
  [rails_c1_id, 'イントロダクション'],
  ['20002', '開発環境の構築'],
  ['20003', 'ルーティング'],
].each do |id, title|
  Chapter.create!(
    { id: id, title: title, course_id: rails_id}
  )
end

### RSpec rails_c1_id:イントロダクション sections
[
  ['20001', 'Ruby on Railsで業務システムを開発する'],
  ['20002', '本コースの構成'],
].each do |id, title|
  Section.create!(
    { id: id, title: title, content: '', chapter_id: rails_c1_id}
  )
end

name = "例山 例太"
profile = "こんにちは、#{name}です。webエンジニアを目指して、ポテパンキャンプでプログラミング学習中です。気軽 にフォローしてください！"
website = "https://railstutorial.jp"

User.create!(name: name,
             email: "example@railstutorial.org",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true,
             profile: profile,
             website: website)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               profile: "こんにちは、#{name}です。webエンジニアを目指して、ポテパンキャンプでプログラミング学習中です。気軽 にフォローしてください！",
               website: website)
end

20.times do
  User.find(1).microposts.create!(content: "チュートリアルの猫",
                          picture: File.open("./public/images/kitten.jpg"))
end
20.times do
  User.find(2).microposts.create!(content: "わんこ",
                          picture: File.open("./public/images/dog.jpg"))
end
20.times do
  User.find(3).microposts.create!(content: "RSpecでお馴染みカピバラ",
                          picture: File.open("./public/images/capybara.jpg"))
end
20.times do
  User.find(4).microposts.create!(content: "いけてる亀！",
                          picture: File.open("./public/images/kame.jpg"))
end
20.times do
  User.find(5).microposts.create!(content: "ちょ、待てよ！",
                          picture: File.open("./public/images/mouse.jpeg"))
end
20.times do
  User.find(6).microposts.create!(content: "ルビーハチドリ",
                          picture: File.open("./public/images/ruby.jpeg"))
end



# リレーションシップ
users = User.all
user  = users.first
following = users[1..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
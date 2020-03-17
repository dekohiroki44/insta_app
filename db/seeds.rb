User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
content = Faker::Lorem.sentence(5)
# users = User.order(:created_at).take(6)
# 50.times do
#   content = Faker::Lorem.sentence(5)
#   users.each { |user| user.microposts.create!(content: content,
# picture: File.open("./public/images/kitten.jpg")) }
# end

user1 = User.find(1)
50.times do
  user1.microposts.create!(content: content,
                           picture: File.open("./public/images/kitten.jpg"))
end
user2 = User.find(2)
50.times do
  user2.microposts.create!(content: content,
                           picture: File.open("./public/images/dog.jpg"))
end
user3 = User.find(3)
50.times do
  user3.microposts.create!(content: content,
                           picture: File.open("./public/images/capybara.jpg"))
end
user4 = User.find(4)
50.times do
  user4.microposts.create!(content: content,
                           picture: File.open("./public/images/kame.jpg"))
end
user5 = User.find(5)
50.times do
  user5.microposts.create!(content: content,
                           picture: File.open("./public/images/mouse.jpeg"))
end
user6 = User.find(6)
50.times do
  user6.microposts.create!(content: content,
                           picture: File.open("./public/images/ruby.jpeg"))
end



# リレーションシップ
users = User.all
user  = users.first
following = users[1..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
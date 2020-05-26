FactoryBot.define do
  factory :micropost do
    picture { File.open("#{Rails.root}/public/images/kitten.jpg")}
    content { "Lorem ipsum" }
    user
  end
end

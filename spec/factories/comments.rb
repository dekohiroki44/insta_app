FactoryBot.define do
  factory :comment do
    content { "MyString" }
    user { 1 }
    micropost { 1 }
  end
end

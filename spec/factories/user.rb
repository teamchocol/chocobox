FactoryBot.define do
  factory :user do
    name { 'user_test1' }
    nickname { 'テストユーザー' }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number: 20) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end

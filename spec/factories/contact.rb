FactoryBot.define do
  factory :contact do
    name { 'TestUser' }
    email { 'test@chocobox.jp' }
    title { 'テストタイトル' }
    content { 'テストコンテント' }
  end
end

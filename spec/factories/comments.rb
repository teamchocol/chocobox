FactoryBot.define do
  factory :commnet do
    title { 'テストタイトル' }
    taste  { '3' }
    healthy  { '3' }
    cost_performance  { '3' }
    item_code { 'test:00000' }
    content { 'テストコンテント' }
    association :user
  end
end
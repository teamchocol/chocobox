class Brand < ApplicationRecord
  # アイテムとの関連付け ##brandが削除されたら紐づいたchocolateのbrand_idはnil
  has_many :chocolates, dependent: :nullify
  attachment :brand_image
  # ページネーションの表示件数追加
  paginates_per 9

  # 検証
  validates :name, presence: true, length: {maximum: 50}
 

  
end

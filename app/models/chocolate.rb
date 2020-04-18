class Chocolate < ApplicationRecord
  # 商品登録用
  validates :title, presence: true, length: {maximum: 255}
  ## urlは255字以上のためデータ型が'text
  validates :url, presence: true
  validates :image_url, presence: true, length: {maximum: 255}
  ## ASINコードで一意に識別
  validates :asin, presence: true, uniqueness: true, length: {maximum: 255}
  
  attachment :image
  # ページネーションの表示件数追加
  paginates_per 12

  # 口コミ投稿との関連付け
  has_many :comments, dependent: :destroy

  # ブランドとの関連付け
  belongs_to :brand, optional: true

  # お気に入り機能追加用中間テーブル追加
  has_many :favorites, foreign_key: 'product_id', dependent: :destroy
  has_many :users, through: :favorites

  attachment :profile_image, destroy: false

  
    

    
  
   
  
end

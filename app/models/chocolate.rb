class Chocolate < ApplicationRecord

  ## urlは255字以上のためデータ型が'text

 
  ## ASINコードで一意に識別
 
  
  
  # ページネーションの表示件数追加
  # paginates_per 12

  # 口コミ投稿との関連付け
  # has_many :comments, dependent: :destroy

  # ブランドとの関連付け
  belongs_to :brand, optional: true

  # お気に入り機能追加用中間テーブル追加
  # has_many :favorites, foreign_key: 'product_id', dependent: :destroy
  # has_many :users, through: :favorites



  
    

    
  
   
  
end

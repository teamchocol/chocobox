class Chocolate < ApplicationRecord
  # 口コミ投稿との関連付け
  has_many :comments, dependent: :destroy
  # ブランドとの関連付け
  belongs_to :brand, optional: true
  # お気に入り機能追加用中間テーブル追加
  has_many :favorites, dependent: :destroy
  
  belongs_to :user
  
  # クラスメソッドとして呼んでいたが下記に修正できた
  # def self.total_taste(id)
  #   chocolate = Chocolate.find(id) 
  #     # レコードが見つからない場合は規定値を返す
  #     unless chocolate
  #       return 0 
  #     end
  #   comments = chocolate.comments
  #   sum = 0
  #   comments.each do |a|
  #     sum += (a.taste.round(1))/comments.count.to_i
  #   end
  #   return sum.round(1)
  # end

def total_taste
  (comments.sum(&:taste) / comments.count).round(1)
  rescue ZeroDivisionError
    "-"
end
def total_healthy
  (comments.sum(&:healthy) / comments.count).round(1)
  rescue ZeroDivisionError
    "-"
end
def total_cost_performance
  (comments.sum(&:cost_performance) / comments.count).round(1)
  rescue ZeroDivisionError
    "-"
end

def favorited_by?(user)
  favorites.where(user_id: user.id).exists?
end
    ## urlは255字以上のためデータ型が'text

 
  ## ASINコードで一意に識別
 
  
  
  # ページネーションの表示件数追加
  # paginates_per 12



  
  
end

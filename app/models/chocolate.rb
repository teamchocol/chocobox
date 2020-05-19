class Chocolate < ApplicationRecord
  # 楽天APIから直接取得  テーブルを使用しないため
  # # 口コミ投稿との関連付け
  # has_many :comments, dependent: :destroy
  # # お気に入り機能追加用中間テーブル追加
  # has_many :favorites, dependent: :destroy
  # belongs_to :user
 
# item_codeインスタンス化
def set_item_code(item_code)
  @item_code = item_code
end
# item_codeを取得
def get_item_code()
  return @item_code
end

# コメントテーブルからitem_code取得
# オブジェクト作成
def comments
  Comment.where(item_code: @item_code).order(created_at: "desc")
end

# item_codeに紐づいたおいしさ評価の平均値
def total_taste
  (comments.sum(&:taste) / comments.count).round(1)
  rescue ZeroDivisionError
    "-"
end
# item_codeに紐づいた健康評価の平均値
def total_healthy
  (comments.sum(&:healthy) / comments.count).round(1)
  rescue ZeroDivisionError
    "-"
end
# item_codeに紐づいたコスパ評価の平均値
def total_cost_performance
  (comments.sum(&:cost_performance) / comments.count).round(1)
  rescue ZeroDivisionError
    "-"
end
  # クラスメソッドとして呼んでいたが上記に修正
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
  
  # ページネーションの表示件数追加
  paginates_per 15 
  
end

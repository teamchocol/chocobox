class Chocolate < ApplicationRecord
  # item_codeインスタンス化
  def set_item_code(item_code)
    @item_code = item_code
  end

  # item_codeを取得
  def get_item_code()
    @item_code
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
    0
  end

  # item_codeに紐づいた健康評価の平均値
  def total_healthy
    (comments.sum(&:healthy) / comments.count).round(1)
  rescue ZeroDivisionError
    0
  end

  # item_codeに紐づいたコスパ評価の平均値
  def total_cost_performance
    (comments.sum(&:cost_performance) / comments.count).round(1)
  rescue ZeroDivisionError
    0
  end

  # ページネーションの表示件数追加
  paginates_per 15
end

class HomeController < ApplicationController
  def top
    # おいしさランキングの表示
    @items_full = []
    group = Comment.where("item_code<>'' and taste<>''").
      reorder("average_taste desc").group(:item_code).average("taste")
    group.each do |k, v|
      item = Rakuten.get_item(k)
      if item["Items"].present?
        @items_full.push(item)
      end
    end
    @items = Kaminari.paginate_array(@items_full).page(params[:page]).per(4)
    @chocolate = Chocolate.new
    # いいねランキングの表示
    @chocolates_full = []
    ranking_list = Favorite.group(:item_code).order('count(item_code) desc').limit(10)
    ranking_list.each do |a|
      item = Rakuten.get_item(a.item_code)
      if item["Items"].present?
        @chocolates_full.push(item)
      end
    end
    @chocolates = Kaminari.paginate_array(@chocolates_full).page(params[:page]).per(8)
  end

  def about
  end

  def sorry
  end

  def health
  end

  def privacypolicy
  end

  def policy
  end

  private

  def comment_params
    params.require(:comment).permit(
      :title,
      :content,
      :image,
      :taste,
      :healthy,
      :cost_performance,
      :item_code,
      :x,
      :y,
      :width,
      :height
    )
  end
end

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
    @chocos_full = []
    ranking_list = Favorite.group(:item_code).order('count(item_code) desc').limit(5)
    ranking_list.each do |r|
      choco = Rakuten.get_item(r.item_code)
      if choco["Items"].present?
        @chocos_full.push(choco)
      end
    end
    @chocolates = Kaminari.paginate_array(@chocos_full).page(params[:page]).per(5)
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
    params.permit(:content, :title, :image, :item_code)
  end
end

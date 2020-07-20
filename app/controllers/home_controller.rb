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

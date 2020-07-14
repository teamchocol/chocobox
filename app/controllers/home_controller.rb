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

    # トップページに最新のコメントが４件表示するため
    @users = User.all
    @comments = Comment.page(params[:page]).without_count.per(2).order(created_at: :desc)
    @name = {}
    @image = {}
    @comments.each do |comment|
      item_code = comment.item_code
      if item_code.present?
        chocolate = Rakuten.get_item(item_code)
        next if chocolate["Items"].blank?
        image_url = chocolate["Items"][0]["Item"]["mediumImageUrls"][0]["imageUrl"]
        item_name = chocolate["Items"][0]["Item"]["itemName"]
        if image_url.present?
          @image[item_code] = image_url
        end
        if item_name.present?
          @name[item_code] = item_name
        end
      end
    end
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

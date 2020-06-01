class ChocolatesController < ApplicationController
  before_action :authenticate_user!
  def index
    @chocolates = RakutenWebService::Ichiba::Genre[201136].ranking.page(1)
  end

  def show
    @chocolate = Rakuten.get_item(params[:id])
    if @chocolate["Items"] == []
      return redirect_to home_sorry_path
    end
    @choco = Chocolate.new
    @choco.set_item_code(params[:id])
    @comment = Comment.new
  end

  def search
    if params[:keyword]
      items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
      @items_full = []
      items.each do |item|
        if item.name.include?("チョコ") and item.name.include?("スマホ") == false
          @items_full.push(item)
        end
      end
      if @items_full.present?
        @items = Kaminari.paginate_array(@items_full).page(params[:page]).per(15)
      end
    end
  end

  def ranking
    @chocolates = RakutenWebService::Ichiba::Genre[201136].ranking
    @range = params[:range]
    if @range == '1'
      redirect_to chocolates_path
    elsif @range == '2'
      @last_chocolates = @chocolates.page(@range.to_i)
    elsif @range == '3'
      @last_chocolates = @chocolates.page(@range.to_i)
    else
      @last_chocolates = @chocolates.page(4)
    end
  end

  def favorite_ranking
    @items_full = []
    ranking_list = Favorite.group(:item_code).order('count(item_code) desc').limit(10)
    ranking_list.each do |a|
      item = Rakuten.get_item(a.item_code)
      if item["Items"].present?
        @items_full.push(item)
      end
    end
    @items = Kaminari.paginate_array(@items_full).page(params[:page]).per(5)
  end

  def taste_ranking
    @items = []
    group = Comment.where("item_code<>'' and taste<>''").
      reorder("average_taste desc").group(:item_code).average("taste")
    group.each do |k, v|
      item = Rakuten.get_item(k)
      if item["Items"].present?
        @items.push(item)
      end
    end
    @chocolate = Chocolate.new
  end

  def healthy_ranking
    @items = []
    group = Comment.where("item_code<>'' and healthy<>''").
      reorder("average_healthy desc").group(:item_code).average("healthy")
    group.each do |k, v|
      item = Rakuten.get_item(k)
      if item["Items"].present?
        @items.push(item)
      end
    end
    @chocolate = Chocolate.new
  end

  def cost_performance_ranking
    @items = []
    group = Comment.where("item_code<>'' and cost_performance<>''").
      reorder("average_cost_performance desc").group(:item_code).average("cost_performance")
    group.each do |k, v|
      item = Rakuten.get_item(k)
      if item["Items"].present?
        @items.push(item)
      end
    end
    @chocolate = Chocolate.new
  end

  private

  def comment_params
    params.permit(:content, :title, :image, :item_code)
  end
  # def chocolate_params
  #   params.permit(:name, :medium_image_url, :price, :item_code)
  # end
  # チョコレートテーブルに保存するように設定した時に使用
end

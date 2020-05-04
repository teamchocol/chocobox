class ChocolatesController < ApplicationController
  def index 
      @chocolates = RakutenWebService::Ichiba::Genre[201136].ranking.page(1) 
  end
 
  def show
    @comments = Comment.where(item_code: params[:id])
    @chocolate = Rakuten.get_item(params[:id])
    if @chocolate["Items"] == []
     return redirect_to home_sorry_path
    end
    @choco = Chocolate.new
    @choco.set_item_code(params[:id])
    @comment = Comment.new
  end

  def create
    @chocolate = Comment.new(chocolate_params)
    @chocolate.user = current_user
    @chocolate.save!
    redirect_to chocolate_path(@chocolate)
  end

  def search
    if params[:keyword]  
      items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
      @items_full = []
      items.each do |item|
        if item.name.include?("チョコレート")
         @items_full.push(item)        
        end
      end
      if @items_full.present?
       @items = Kaminari.paginate_array(@items_full).page(params[:page]).per(20)
      end
    end
  end

  def ranking
    @chocolates = RakutenWebService::Ichiba::Genre[201136].ranking
    @range = params[:range]
     if @range == '1' 
      redirect_to chocolates_path
     elsif 
      @range == '2'
      @last_chocolates = @chocolates.page(@range.to_i) 
     elsif 
      @range == '3'
      @last_chocolates = @chocolates.page(@range.to_i) 
    else
      @last_chocolates = @chocolates.page(4) 
    end
  end

  def favorite_ranking
    
    @items = []
    ranking_list = Favorite.group(:item_code).order('count(item_code) desc').limit(10)
    ranking_list.each do |a|
    item = Rakuten.get_item(a.item_code)
      if item["Items"].present? 
        @items.push(item)        
      end 
    end
  end
  
 private
  def chocolate_params
    params.permit(:name, :medium_image_url, :price, :item_code)
  end
  def comment_params
    params.permit(:content, :title, :image_id, :item_code )
  end
end

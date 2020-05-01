class ChocolatesController < ApplicationController
  def index 
      @chocolates = RakutenWebService::Ichiba::Genre[201136].ranking
  end
 
  def show
    @comments = Comment.where(item_code: params[:id])
    @chocolate = Rakuten.get_item(params[:id])
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
      @items = []
      items.each do |item|
        if item.name.include?("チョコレート")
         @items.push(item)        
         end
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
  
 private
  def chocolate_params
    params.permit(:name, :medium_image_url, :price, :item_code)
  end
  def comment_params
    params.permit(:content, :title, :image_id, :item_code )
  end
end

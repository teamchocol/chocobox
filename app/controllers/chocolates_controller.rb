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
  
 private
  def chocolate_params
    params.permit(:name, :medium_image_url, :price, :item_code)
  end
  def comment_params
    params.permit(:content, :title, :image_id, :item_code )
  end
  helper_method :total_taste
end

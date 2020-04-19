class ChocolatesController < ApplicationController
  def new
   
  end
  
  def index
    @chocolates = Chocolate.all
  end
  def show
     @chocolate = Chocolate.find(params[:id])
  end
  def create
    @chocolate = Chocolate.new(chocolate_params)
   
    @chocolate.save
   
    redirect_to chocolate_path(@chocolate)
  end

  def search
    if params[:keyword]
    @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end

  end
  

 private

 def chocolate_params
   params.permit(:rakuten_chocolate_name_url, :medium_image_url, :price, :brand_id)
 end
end
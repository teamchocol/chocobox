class Admin::ChocolatesController < ApplicationController
  def index
    @chocolates = Chocolates.all

  end

  def show
    @chocolate = Chocolate.find(params[:id])
    @tax_price = ((@chocolate.price.to_i * 1.1).round(2)).ceil.to_i
  end

  def new
  	@chocolate = Chocolate.new
  end

  def create
    @chocolate = Chocolate.new(chocolate_params)
    if @chocolate.save
    redirect_to admin_chocolate_path(@chocolate)
  else
    render :index
  end
  end


  def edit
    @chocolate = Chocolate.find(params[:id])
  end

  def update
    @chocolate = Chocolate.find(params[:id])
    redirect_to admin_chocolate_path(@chocolate)
  end




private

  def item_params
    params.require(:item).permit(:name, :text, :price, :sell_status, :brand_id, :profile_image, :range)
  end

end

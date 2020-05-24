class Admin::BrandsController < ApplicationController
  def index
    @brands = Brand.all
    @brand = Brand.new
  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      redirect_to admin_brands_path
    else
      @brands = Brand.all
      render 'index'
    end
  end

  def update
    @brand = Brand.find(params[:id])
    if @brand.update(brand_params)
      redirect_to admin_brands_path
    else
      render :edit
    end
  end

  private

  def brand_params
    params.require(:brand).permit(:name, :brand_image, :id, :status)
  end
end

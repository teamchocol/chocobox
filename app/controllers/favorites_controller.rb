class FavoritesController < ApplicationController
  before_action :set_variables
  def create
    favorite = current_user.favorites.new(item_code: params[:chocolate_id])
    favorite.save 
  end

  def destroy
    favorite = current_user.favorites.find_by(item_code: params[:chocolate_id])
    favorite.destroy
  end

  private
  def set_variables
    @chocolate = Rakuten.get_item(params[:chocolate_id])
    @id_name
      if @chocolate.present?
        @id_name = "#like-link-#{@chocolate['Items'][0]['Item']['itemCode'].delete(":")}"
      end
    @chocolate = {"itemCode" => @chocolate['Items'][0]['Item']['itemCode']}
  end
end

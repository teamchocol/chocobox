class FavoritesController < ApplicationController
  def create
    Favorite.where(item_code: @item_code)
    favorite = current_user.favorites.new(item_code: item_code)
    favorite.save
    redirect_to request.referrer || root_url
   end

  def destroy
    Favorite.where(item_code: @item_code)
    favorite = current_user.favorites.find_by(item_code: item_code)
    favorite.destroy
    redirect_to request.referrer || root_url
  end

  private
  # def set_variables
  #   @chocolate = Chocolate.find(params[:chocolate_id])
  #   @id_name = "#like-link-#{@chocolate.id}"
  # end
end

class FavoritesController < ApplicationController
  def create
    chocolate = Chocolate.find(params[:chocolate_id])
    favorite = current_user.favorites.new(chocolate_id: chocolate.id)
    favorite.save
    redirect_to request.referrer || root_url
   end

  def destroy
    chocolate = Chocolate.find(params[:chocolate_id])
    favorite = current_user.favorites.find_by(chocolate_id: chocolate.id)
    favorite.destroy
    redirect_to request.referrer || root_url
  end

  private
  def set_variables
    @chocolate = Chocolate.find(params[:chocolate_id])
    @id_name = "#like-link-#{@chocolate.id}"
  end
end

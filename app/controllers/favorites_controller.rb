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
    # @chocolate = RakutenWebService::Ichiba::Item.search(itemCode: params[:chocolate_id]).first
    # if @chocolate.nil?
    #   @id_name = nil
    #   @chocolate = {"itemCode" => params[:chocolate_id]}
    # else
      @id_name = "#like-link-#{params[:chocolate_id].delete(":")}"
      @chocolate = {"itemCode" => params[:chocolate_id]}
    # end
  end
end

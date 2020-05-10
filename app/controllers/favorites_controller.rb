class FavoritesController < ApplicationController
  before_action :set_variables
  def create
    # favarites = Favorite.where(item_code: item_code, user_id: current_user.id)
    # if favarites.present?
    # end
    favorite = current_user.favorites.new(item_code: params[:chocolate_id])
    favorite.save
    # result = [done: "save",user_id: current_user.id]
    # render :json => result
   end

  def destroy
    favorite = current_user.favorites.find_by(item_code: params[:chocolate_id])
    favorite.destroy
    # result = [done: "destroy",user_id: current_user.id]
    # render :json => result
    # チョコレと変数
    # 再考
    # redirect_to request.referrer || root_url
  end

  private
  def set_variables
    @chocolate = Rakuten.get_item(params[:chocolate_id])
    @id_name
      if @chocolate.present?
        @id_name = "#like-link-#{@chocolate['Items'][0]['Item']['itemCode'].delete(":")}"
      end
    @chocolate = {"itemCode" => @chocolate['Items'][0]['Item']['itemCode']}
    # @item_code = @chocolate['Items'][0]['Item']['itemCode']
  end
end

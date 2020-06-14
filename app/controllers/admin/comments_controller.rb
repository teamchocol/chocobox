class Admin::CommentsController < ApplicationController
  def destroy
    @choco = Chocolate.new
    @comment = Comment.find(params[:id])
    @choco.set_item_code(@comment.item_code)
    if @comment.user == current_user
      @comment.destroy
    else
      flash[:alert] = "削除できませんでした"
      redirect_to request.referer
    end
  end

  def index
    @users = User.all
    @comments = Comment.page(params[:page]).without_count.per(4).order(created_at: :desc)
    @name = {}
    @image = {}
    @comments.each do |comment|
      item_code = comment.item_code
      if item_code.present?
        chocolate = Rakuten.get_item(item_code)
        puts chocolate
        next if chocolate["Items"].blank?
        image_url = chocolate["Items"][0]["Item"]["mediumImageUrls"][0]["imageUrl"]
        item_name = chocolate["Items"][0]["Item"]["itemName"]
        if image_url.present?
          @image[item_code] = image_url
        end
        if item_name.present?
          @name[item_code] = item_name
        end
      end
    end
  end
end

class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @new_comment = current_user.comments.new(comment_params)
    if @new_comment.save
      session[:crop_x] = comment_params[:x]
      session[:crop_y] = comment_params[:y]
      session[:crop_width] = comment_params[:width]
      session[:crop_height] = comment_params[:height]
    else
      redirect_to chocolate_path(@new_comment.item_code), flash: { error: @new_comment.errors.full_messages }   
    end
    @comment = Comment.new
    @chocolate = Chocolate.new
    @chocolate.set_item_code(@new_comment.item_code)
  end

  def destroy
    @choco = Chocolate.new
    @comment = Comment.find(params[:id])
    @choco.set_item_code(@comment.item_code)
    if @comment.user == current_user
      @comment.destroy
      flash[:success] = "コメントを削除しました!"
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
        imageUrl = chocolate["Items"][0]["Item"]["mediumImageUrls"][0]["imageUrl"]
        itemName = chocolate["Items"][0]["Item"]["itemName"]
        if imageUrl.present?
          @image[item_code] = imageUrl
        end
        if itemName.present?
          @name[item_code] = itemName
        end
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :content, :image, :taste, :healthy, :cost_performance, :item_code, :x, :y, :width, :height)
  end
end

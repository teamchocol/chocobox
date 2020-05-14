class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @new_comment = current_user.comments.new(comment_params)
    
    # if 
    @new_comment.save
      # flash[:success] = "You have commented  successfully."
      # redirect_to chocolate_path(@comment.item_code)
    # else 
    #   render template:'chocolates/show'
    # end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if comment.user != current_user
      redirect_to request.referer
    end
    @comment.destroy
    redirect_to request.referer
    flash[:success] = "successfully delete comment!"
  end

  def index
    @users = User.all
    @comments = Comment.page(params[:page]).per(6)
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
      params.require(:comment).permit(:title, :content, :image, :taste, :healthy, :cost_performance, :item_code)
  end
end

class CommentsController < ApplicationController
  
  def create
    @comment = current_user.comments.new(comment_params)
    
    if @comment.save 
      flash[:success] = "You have commented  successfully."
      redirect_to chocolate_path(@comment.item_code)
    else 
      render template:'chocolates/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:item_code])
    if comment.user != current_user
      redirect_to request.referer
    end
    @comment.destroy
    redirect_to request.referer
    flash[:success] = "successfully delete comment!"
  end

  def index
    @comments = Comment.all
    @users = User.all
    @chocolate = Rakuten.get_item(params[:item_code])
  end
 
  private
  def comment_params
      params.require(:comment).permit(:title, :content, :image, :taste, :healthy, :cost_performance, :item_code)
  end
end

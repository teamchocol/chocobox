class CommentsController < ApplicationController
  def create
    @chocolates = Chocolate.all
    @new = Chocolate.new
    @chocolate = Chocolate.find(params[:chocolate_id])
    @comment = current_user.comments.new(comment_params)
    puts comment_params
    @comment.chocolate_id = @chocolate.id
    
    if @comment.save 
      flash[:success] = "You have commented  successfully."
      redirect_to chocolate_path(@chocolate)
    else 
      render template:'chocolates/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:chocolate_id])
    if comment.user != current_user
      redirect_to request.referer
    end
    @comment.destroy
    redirect_to request.referer
    flash[:success] = "successfully delete comment!"
  end

  def index
    @comments = Comment.all
    @chocolate = Chocolate.find(params[:id])
  end

  private
  def comment_params
      params.require(:comment).permit(:title, :content, :image, :taste, :healthy, :cost_performance,)
  end
end

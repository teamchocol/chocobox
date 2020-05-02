class SearchesController < ApplicationController
  def user_search
    search = params[:search]
    word = params[:word]
    @user = User.search(search,word)
  end

  def comment_search
    search = params[:search]
    word = params[:word]
    @comment = Comments.search(search,word)
  end
end

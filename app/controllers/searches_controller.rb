class SearchesController < ApplicationController
  def user_search
    search = params[:search]
    word = params[:word]
    @user = User.search(search,word)

  end

  def search
    search = params[:search]
    word = params[:word]
    @comment = Comment.search(search,word)
  end
end


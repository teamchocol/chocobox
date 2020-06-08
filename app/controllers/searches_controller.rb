class SearchesController < ApplicationController
  def user_search
    search = params[:search]
    word = params[:word]
    @users = User.user_search(search, word)
  end

  def search
    search = params[:search]
    word = params[:word]
    @comments = Comment.search(search, word)
  end
end

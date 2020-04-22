class CommentsController < ApplicationController
  def create
  end

  def destroy
  end

  def index
    @comments = Comment.all
  end
end

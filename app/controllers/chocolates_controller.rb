class ChocolatesController < ApplicationController
  def new
    @products = Chocolate.new(params[:keyword])
  end
  def create
  end
  def index
  end
  def show
  end
end

class UsersController < ApplicationController
  before_action :authenticate_user!

  def followers
    @followers = User.find(params[:id])
  end

  def follows
    @follows = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @comments = Comment.page(params[:page]).without_count.per(4).order(created_at: :desc)
    @name = {}
    @image = {}
    @comments.each do |comment|
      item_code = comment.item_code
      if item_code.present?
        chocolate = Rakuten.get_item(item_code)
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

  def index
    @users = User.page(params[:page]).per(6)
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
    if @user.id == 2
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報の編集が完了しました"
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def favorite_chocolates
    @user = User.find(params[:id])
    @items_full = []
    favorite = Favorite.where(user_id: @user.id)
    favorite.each do |favo|
      item = Rakuten.get_item(favo.item_code)
      if item["Items"] != []
        @items_full.push(item)
      end
    end
    @items = Kaminari.paginate_array(@items_full).page(params[:page]).per(6)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :nickname, :age, :gender)
  end

  # url直接防止 メソッドを自己定義してbefore_actionで発動。
  def correct_user
    @user = User.find(id: params[:id])
    unless @user
      redirect_to new_user_session
    end
  end
end

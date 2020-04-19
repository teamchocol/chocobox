class UsersController < ApplicationController
  before_action :authenticate_user!

  def followers
    @followers  = User.find(params[:id])
  end
	
	def follows 
		@follows = User.find(params[:id])
		
	end

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
		@new = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
		
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
		@new = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
	  
	end

  def edit
		@user = User.find(params[:id])
		if @user.id != current_user.id
    redirect_to user_path(current_user)
	  end
	end

  def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "You have updated user successfully."
  		redirect_to user_path(@user.id)
  	else
  		render "edit"
  	end
  end
	
	def zipedit
		params.require(:user).permit(:postcode, :prefecture_name, :address_city, :address_street, :address_building)
	end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image, :postcode, :prefecture_name, :address_city, :address_street, :address_building)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。

		def book_params
				params.require(:book).permit(:title, :body)
		end

	def correct_user
		@user = User.find(id: params[:id])
			unless @user
				redirect_to new_user_session
			end
	end
end

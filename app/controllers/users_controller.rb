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
  end

  def index
		@users = User.page(params[:page]).per(6) 
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
	
	def search
		@users = User.search(params[:search])
	end
	
	# def hide
	# 	@user = User.find(params[:id])
	# 	#is_deletedカラムにフラグを立てる(defaultはfalse)
	# 	@user.update(is_deleted: true)
	# 	#ログアウトさせる
	# 	reset_session
	# 	flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
	# 	redirect_to root_path
	# end
	
  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image, :nickname, :age, :gender)
  end
	#url直接防止　メソッドを自己定義してbefore_actionで発動。
	
	def correct_user
		@user = User.find(id: params[:id])
			unless @user
				redirect_to new_user_session
			end
	end
end

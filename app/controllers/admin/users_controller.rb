class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.page(params[:page]).per(6)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    flash[:notice] = "編集しました"
    redirect_to admin_user_path(@user.id)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = " ユーザーを削除しました!"
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :nickname, :age, :gender)
  end
end

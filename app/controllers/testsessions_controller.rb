class TestsessionsController < ApplicationController
  def create
    user=User.find_by(email:"test@example.com")
    
    session[:user_id] = user.id
    flash[:success] = "テストユーザとしてログインしました。"
    redirect_to user
  end
end

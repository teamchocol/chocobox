class RelationshipsController < ApplicationController
  before_action :authenticate_user! 
  def create 
    active_relationship = current_user.user.new(follower_id: current_user.id, followed_id: user.id)
     active_relationship.save
     redirect_to request.referrer || root_url
  end

  def destroy
    user = User.find(params[:follow_id])
    following = current_user.unfollow(user)
    following.destroy
    redirect_to request.referrer || root_url
  end
  
  def follow
    current_user.follow(params[:id])
    redirect_to request.referrer || root_url
  end
  
  def unfollow
    current_user.unfollow(params[:id])
    redirect_to request.referrer || root_url
  end

  def index
    @active_relationships = Relationship.all
  end

  private
  def set_user
    @user = User.find(params[:relationship][:follow_id])
  end
end

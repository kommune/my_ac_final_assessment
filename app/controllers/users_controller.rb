class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all

    def follower?(user)
      followers.find_by(user.id)
    end
  
    def following?(user)
      byebug
      followings.find_by(params:[:id])
    end
  end

  def follow
    @follow = Relationship.new(follower_id: params[:follower], following_id: params[:following])
    @follow.save
    redirect_to users_path
  end

  def unfollow
    @unfollow = Relationship.find(params[:id])
    @unfollow.destroy
    redirect_to users_path
  end

  def follower
    @users = current_user.followers
  end

  def following
    @users = current_user.followings
  end
end

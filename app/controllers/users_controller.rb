class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def follow
    followee = User.find(params[:id])
    current_user.followings << followee
    redirect_to users_path
  end

  def unfollow
    relationship = Relationship.find_by(following_id: params[:id])
    current_user.followings.delete(relationship.following_id)
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end

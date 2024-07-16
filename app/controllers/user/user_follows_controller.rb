class User::UserFollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.follow(@user)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    current_user.unfollow(@user)
    respond_to do |format|
      format.js
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
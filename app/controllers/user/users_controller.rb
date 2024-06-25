# app/controllers/user/users_controller.rb
class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :liked_posts, :following]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_without_password(user_params)
      redirect_to @user, notice: 'ユーザー情報が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path, notice: 'アカウントが削除されました。'
  end
  
  def liked_posts
    @liked_posts = @user.liked_posts
  end

  def following
    @following_users = @user.following
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation)
  end
end
class User::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.where(is_public: true)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post), notice: 'レシピが投稿されました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'レシピが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'レシピが削除されました。'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
  
  def correct_user
    unless @post.user == current_user
      redirect_to posts_path, alert: '他人の投稿は編集・削除できません。'
    end
  end
  
  def post_params
    params.require(:post).permit(:menu_title, :genre_id, :image, :energy, :protein, :fat, :calcium, :iron, :zinc, :vitamin_a, :vitamin_b1, :vitamin_b2, :vitamin_c, :dietary_fiber, :salt, :notes, :is_public)
  end
end
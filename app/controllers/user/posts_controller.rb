class User::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :check_post_visibility, only: [:show]

  def index
    @posts = Post.where(is_public: true)
  end

  def show
    @user = @post.user
    @is_following = current_user.following?(@user)
  end

  def new
    @post = Post.new
    @post.post_ingredients.build
    @ingredients = Ingredient.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    begin
      tags = Vision.get_image_data(post_params[:image])
    rescue => e
      flash[:alert] = "画像処理中にエラーが発生しました: #{e.message}"
      @ingredients = Ingredient.all
      render :new and return
    end

    if @post.save
      tags.each do |tag|
        @post.tags.create(name: tag)
      end
      redirect_to post_path(@post), notice: 'レシピが投稿されました。'
    else
      @ingredients = Ingredient.all
      render :new
    end
  end

  def edit
    @ingredients = Ingredient.all
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'レシピが更新されました。'
    else
      @ingredients = Ingredient.all
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'レシピが削除されました。'
  end

  def by_genre
    @genre = Genre.find(params[:id])
    @posts = @genre.posts
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

  def check_post_visibility
    unless @post.is_public || @post.user == current_user
      redirect_to root_path, alert: 'この投稿は非公開です。'
    end
  end

  def post_params
    params.require(:post).permit(:menu_title, :genre_id, :image, :energy, :protein, :fat, :calcium, :iron, :zinc, :vitamin_a, :vitamin_b1, :vitamin_b2, :vitamin_c, :dietary_fiber, :salt, :notes, :is_public, post_ingredients_attributes: [:id, :ingredient_id, :quantity, :_destroy])
  end
end
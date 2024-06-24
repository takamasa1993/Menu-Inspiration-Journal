class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :by_genre]

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: 'レシピが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: 'レシピが削除されました。'
  end

  def by_genre
    @genre = Genre.find(params[:id])
    @posts = @genre.posts.where(is_public: true)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
  
  def post_params
    params.require(:post).permit(:menu_title, :genre_id, :image, :energy, :protein, :fat, :calcium, :iron, :zinc, :vitamin_a, :vitamin_b1, :vitamin_b2, :vitamin_c, :dietary_fiber, :salt, :notes, :is_public)
  end
end
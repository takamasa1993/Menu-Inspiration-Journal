class User::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)

    if @like.save
      redirect_to request.referer, notice: 'いいねしました。'
    else
      redirect_to request.referer, alert: 'いいねできませんでした。'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(user: current_user)

    if @like.destroy
      redirect_to request.referer, notice: 'いいねを取り消しました。'
    else
      redirect_to request.referer, alert: 'いいねを取り消せませんでした。'
    end
  end
end
class User::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)

    if @like.save
      respond_to do |format|
        format.html { redirect_to request.referer, notice: 'いいねしました。' }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to request.referer, alert: 'いいねできませんでした。' }
        format.js { render js: "alert('いいねできませんでした。');" }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(user: current_user)

    if @like.destroy
      respond_to do |format|
        format.html { redirect_to request.referer, notice: 'いいねを取り消しました。' }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to request.referer, alert: 'いいねを取り消せませんでした。' }
        format.js { render js: "alert('いいねを取り消せませんでした。');" }
      end
    end
  end
end
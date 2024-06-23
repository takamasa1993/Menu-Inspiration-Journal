class User::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: 'コメントが追加されました。'
    else
      redirect_to post_path(@post), alert: 'コメントの追加に失敗しました。'
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@comment.post), notice: 'コメントが削除されました。'
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def correct_user
    unless @comment.user == current_user
      redirect_to post_path(@comment.post), alert: '他人のコメントは削除できません。'
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
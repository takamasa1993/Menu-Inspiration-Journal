class Admin::PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  def show
    @post = Post.find(params[:id])
  end
  
  private

  def set_post
    @post = Post.find(params[:id])
  end
  
end
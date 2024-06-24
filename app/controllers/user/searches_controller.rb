class User::SearchesController < ApplicationController
  def index
    if params[:search].blank?
      @posts = Post.none
    else
      @posts = Post.where('menu_title LIKE ?', "%#{params[:search]}%").where(is_public: true)
    end
  end
end
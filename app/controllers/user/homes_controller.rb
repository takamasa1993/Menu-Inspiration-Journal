class User::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @latest_posts = Post.order(created_at: :desc).limit(4)
  end

  def about
  end
end

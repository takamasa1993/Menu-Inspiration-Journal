class User::HomesController < ApplicationController
  def top
    @latest_posts = Post.order(created_at: :desc).limit(4)
  end

  def about
  end
end

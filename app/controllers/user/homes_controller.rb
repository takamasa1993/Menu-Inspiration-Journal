class User::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @latest_posts_by_genre = Genre.joins(:posts).distinct.map do |genre|
      [genre.name, genre.posts.where(is_public: true).order(created_at: :desc).limit(9)]
    end.to_h
  end
end
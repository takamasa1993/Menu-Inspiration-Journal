class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @genres = Genre.all
  end
  
  
  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "ジャンルを作成しました"
    else
      render :new
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "ジャンルを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admin_genres_path, notice: "ジャンルを削除しました"
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
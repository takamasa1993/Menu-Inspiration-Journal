class User::SearchesController < ApplicationController
  def index
    @query = params[:query]
    @type = params[:type]

    if @type == "menu"
      @results = Post.where('menu_title LIKE ?', "%#{@query}%")
    elsif @type == "user"
      @results = User.where('name LIKE ?', "%#{@query}%")
    else
      @results = []
    end
  end
end
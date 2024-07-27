class User::SearchesController < ApplicationController
  def index
    @query = params[:query]
    @type = params[:type]

    if @type == "menu"
      @results = Post.search_by_title(@query)
    elsif @type == "user"
      @results = User.where('name LIKE ?', "%#{@query}%")
    else
      @results = []
    end
  end
end
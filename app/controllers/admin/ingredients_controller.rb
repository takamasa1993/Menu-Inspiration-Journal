class Admin::IngredientsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_ingredient, only: [:edit, :update, :destroy]

  def index
    @ingredient = Ingredient.new
    @ingredients = Ingredient.all
  end

  def show
    @new_ingredient_proposals = NewIngredientProposal.where(status: 'pending')
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      redirect_to admin_ingredients_path, notice: '材料が登録されました。'
    else
      @ingredients = Ingredient.all
      render :index
    end
  end

  def edit
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to admin_ingredients_path, notice: '材料が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @ingredient.destroy
    redirect_to admin_ingredients_path, notice: '材料が削除されました。'
  end

  private

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
end
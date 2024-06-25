class User::IngredientsController < ApplicationController
  before_action :authenticate_user!

  def new
    @new_ingredient_proposal = NewIngredientProposal.new
    @new_ingredient_proposals = NewIngredientProposal.where(user_id: current_user.id)
  end

  def create
    @new_ingredient_proposal = current_user.new_ingredient_proposals.build(new_ingredient_proposal_params)
    @new_ingredient_proposal.status = 'pending'
    if @new_ingredient_proposal.save
      redirect_to new_ingredient_path, notice: '新材料が提案されました。'
    else
      @new_ingredient_proposals = NewIngredientProposal.where(user_id: current_user.id)
      render :new
    end
  end

  private

  def new_ingredient_proposal_params
    params.require(:new_ingredient_proposal).permit(:name)
  end
end
class Admin::NewIngredientProposalsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @new_ingredient_proposals = NewIngredientProposal.where(status: 'pending')
  end

  def update
    @new_ingredient_proposal = NewIngredientProposal.find(params[:id])
    if @new_ingredient_proposal.update(new_ingredient_proposal_params)
      if @new_ingredient_proposal.status == 'approved'
        Ingredient.create(name: @new_ingredient_proposal.name)
      end
      redirect_to admin_new_ingredient_proposals_path, notice: '材料提案のステータスが更新されました。'
    else
      @new_ingredient_proposals = NewIngredientProposal.where(status: 'pending')
      render :index
    end
  end

  def destroy
    @new_ingredient_proposal = NewIngredientProposal.find(params[:id])
    @new_ingredient_proposal.destroy
    redirect_to admin_new_ingredient_proposals_path, notice: '材料提案が削除されました。'
  end

  private

  def new_ingredient_proposal_params
    params.require(:new_ingredient_proposal).permit(:status)
  end
end
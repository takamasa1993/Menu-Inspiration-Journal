class Admin::NewIngredientProposalsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @new_ingredient_proposals = NewIngredientProposal.where(status: :pending)
  end

  def approve
    @proposal = NewIngredientProposal.find(params[:id])
    @proposal.update(status: :approved)
    Ingredient.create(name: @proposal.name)
    redirect_to admin_new_ingredient_proposals_path, notice: '材料が承認されました。'
  end

  def reject
    @proposal = NewIngredientProposal.find(params[:id])
    @proposal.update(status: :rejected)
    redirect_to admin_new_ingredient_proposals_path, notice: '材料が拒否されました。'
  end

  def destroy
    @proposal = NewIngredientProposal.find(params[:id])
    @proposal.destroy
    redirect_to admin_new_ingredient_proposals_path, notice: '提案が削除されました。'
  end
end
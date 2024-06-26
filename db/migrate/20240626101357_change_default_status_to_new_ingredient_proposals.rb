class ChangeDefaultStatusToNewIngredientProposals < ActiveRecord::Migration[6.1]
  def change
    change_column_default :new_ingredient_proposals, :status, from: nil, to: "pending"
  end
end
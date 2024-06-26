class ChangeStatusColumnTypeInNewIngredientProposals < ActiveRecord::Migration[6.1]
  def up
    change_column :new_ingredient_proposals, :status, :string, default: 'pending'
  end

  def down
    change_column :new_ingredient_proposals, :status, :integer, default: 0, null: false
  end
end
class ChangeDefaultStatusToNewIngredientProposals < ActiveRecord::Migration[6.1]
  def up
    execute "ALTER TABLE new_ingredient_proposals ALTER COLUMN status SET DEFAULT 'pending'"
  end

  def down
    execute "ALTER TABLE new_ingredient_proposals ALTER COLUMN status DROP DEFAULT"
  end
end
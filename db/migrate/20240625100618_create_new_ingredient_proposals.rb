class CreateNewIngredientProposals < ActiveRecord::Migration[6.1]
  def change
    create_table :new_ingredient_proposals do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false, unique: true
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end

class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.string :menu_title
      t.float :energy
      t.float :protein
      t.float :fat
      t.float :calcium
      t.float :iron
      t.float :zinc
      t.float :vitamin_a
      t.float :vitamin_b1
      t.float :vitamin_b2
      t.float :vitamin_c
      t.float :dietary_fiber
      t.float :salt
      t.text :notes
      t.boolean :is_public

      t.timestamps
    end
  end
end

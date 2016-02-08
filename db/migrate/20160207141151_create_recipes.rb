class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :servings
      t.integer :cook_time
      t.string :difficulty
      t.text :steps
      t.text :ingredients
      t.string :photo

      t.timestamps null: false
    end
  end
end

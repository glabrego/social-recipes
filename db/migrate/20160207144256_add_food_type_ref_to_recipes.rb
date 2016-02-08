class AddFoodTypeRefToRecipes < ActiveRecord::Migration
  def change
    add_reference :recipes, :food_type, index: true, foreign_key: true
  end
end

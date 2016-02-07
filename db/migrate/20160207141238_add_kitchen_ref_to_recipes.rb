class AddKitchenRefToRecipes < ActiveRecord::Migration
  def change
    add_reference :recipes, :kitchen, index: true, foreign_key: true
  end
end

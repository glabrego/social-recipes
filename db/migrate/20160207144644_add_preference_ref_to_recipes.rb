class AddPreferenceRefToRecipes < ActiveRecord::Migration
  def change
    add_reference :recipes, :preference, index: true, foreign_key: true
  end
end

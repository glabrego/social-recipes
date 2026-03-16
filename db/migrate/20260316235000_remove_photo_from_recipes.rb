class RemovePhotoFromRecipes < ActiveRecord::Migration[8.1]
  def change
    remove_column :recipes, :photo, :string
  end
end

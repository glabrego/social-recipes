class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :location, :string
    add_column :users, :twitter, :string
    add_column :users, :facebook, :string
  end
end

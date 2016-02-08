class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end

class CreateKitchens < ActiveRecord::Migration
  def change
    create_table :kitchens do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end

class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :kitchens do |t|
      # t.index [:user_id, :kitchen_id]
      # t.index [:kitchen_id, :user_id]
    end
  end
end

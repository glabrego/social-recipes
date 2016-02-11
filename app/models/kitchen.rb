class Kitchen < ActiveRecord::Base
  has_many :recipes
  has_and_belongs_to_many :likers, class_name: :User, join_table: :kitchens_users
end

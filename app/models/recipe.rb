class Recipe < ActiveRecord::Base
  DIFFICULTY_OPTIONS = ['Fácil','Médio','Difícil']
  belongs_to :kitchen
  belongs_to :food_type
  belongs_to :preference
  belongs_to :user
  validates :name, :kitchen_id, :food_type_id, :preference_id, :servings,
  :cook_time, :difficulty, :ingredients, :steps, presence: true

  has_and_belongs_to_many :fans, class_name: :User, join_table: :recipes_users
end

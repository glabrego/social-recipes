class Recipe < ActiveRecord::Base
  DIFFICULTY_OPTIONS = ['Fácil','Médio','Difícil']
  belongs_to :kitchen
  belongs_to :food_type
  belongs_to :preference
end

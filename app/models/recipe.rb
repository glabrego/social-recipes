class Recipe < ActiveRecord::Base
  DIFFICULTY_OPTIONS = %w(Fácil Médio Difícil).freeze
  mount_uploader :photo, PhotoUploader
  belongs_to :kitchen
  belongs_to :food_type
  belongs_to :preference
  belongs_to :user
  validates :name, :kitchen_id, :food_type_id, :preference_id, :servings,
            :cook_time, :difficulty, :ingredients, :steps, presence: true

  has_and_belongs_to_many :fans, class_name: :User, join_table: :recipes_users

  def self.most_favorites(order = nil)
    if order == :asc
      all.sort_by { |recipe| recipe.fans.size }
    else
      all.sort_by { |recipe| -recipe.fans.size }
    end
  end
end

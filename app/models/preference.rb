class Preference < ActiveRecord::Base
  has_many :recipes
end

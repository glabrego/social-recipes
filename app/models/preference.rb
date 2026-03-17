class Preference < ApplicationRecord
  has_many :recipes

  validates :title, presence: true
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def set_collections
    @kitchens = Kitchen.all
    @food_types = FoodType.all
    @preferences = Preference.all
    @recipes = Recipe.all
  end
end

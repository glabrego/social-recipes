class HomeController < ApplicationController
  def index
    @kitchens = Kitchen.all
    @food_types = FoodType.all
    @preferences = Preference.all
    @favorites = Recipe.most_favorites.first(10)
    @recipes = Recipe.last(20) - @favorites
  end
end

class HomeController < ApplicationController
  def index
    @kitchens = Kitchen.all
    @food_types = FoodType.last(20)
    @preferences = Preference.all
    @recipes = Recipe.all
  end
end

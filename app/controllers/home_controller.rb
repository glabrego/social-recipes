class HomeController < ApplicationController
  def index
    @kitchens = Kitchen.all
    @food_types = FoodType.all
    @preferences = Preference.all
    @recipes = Recipe.last(20)
  end
end

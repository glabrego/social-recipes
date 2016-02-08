class RecipesController < ApplicationController
  before_action :set_collections, only: [:new, :create]
  before_action :set_recipe, only: [:show]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.create(recipe_params)
    respond_with @recipe
  end

  def show
  end

  private

  def recipe_params
    params.require(:recipe)
          .permit(:name, :kitchen_id, :food_type_id, :preference_id, :servings,
             :cook_time, :difficulty, :ingredients, :steps)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def set_collections
    @kitchens = Kitchen.all
    @food_types = FoodType.all
    @preferences = Preference.all
  end

end

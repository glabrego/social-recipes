class RecipesController < ApplicationController
  before_action :set_collections, only: [:new, :create, :edit, :update]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: :show

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.create(recipe_params)
    @recipe.user_id = current_user.id
    respond_with @recipe
  end

  def edit
    if current_user.id != @recipe.user_id
      redirect_to root_path, alert: 'You are not allowed to edit that recipe!'
    end
  end

  def update
    @recipe.update(recipe_params)
    respond_with @recipe
  end

  def destroy
    if current_user.id != @recipe.user_id
      redirect_to @recipe, alert: 'You are not allowed to destroy that recipe!'
    else
      @recipe.destroy
      redirect_to root_path, alert: 'Recipe destroyed.'
    end
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

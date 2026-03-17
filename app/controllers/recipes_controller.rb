class RecipesController < ApplicationController
  before_action :set_collections, only: [:new, :create, :edit, :update, :index]
  before_action :set_recipe, except: [:new, :create, :index]
  before_action :authenticate_user!, except: :show

  def index
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      flash.now[:alert] = 'Please complete every field before publishing your recipe.'
      render :new
    end
  end

  def edit
    if current_user.id != @recipe.user_id
      redirect_to root_path, alert: 'You can only edit recipes you created.'
    end
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      flash.now[:alert] = 'Please complete every field before saving your recipe.'
      render :edit
    end
  end

  def destroy
    if current_user.id != @recipe.user_id
      redirect_to @recipe, alert: 'You can only delete recipes you created.'
    else
      @recipe.destroy
      redirect_to root_path, notice: 'Recipe deleted.'
    end
  end

  def show
  end

  def favorite
    if request.delete?
      remove_fan if @recipe.fans.exists?(current_user.id)
      redirect_to @recipe, notice: 'Recipe removed from your saved recipes.'
    else
      add_fan unless @recipe.fans.exists?(current_user.id)
      redirect_to @recipe, notice: 'Recipe saved to your collection.'
    end
  end

  private

  def recipe_params
    params.require(:recipe)
          .permit(:name, :kitchen_id, :food_type_id, :preference_id, :servings,
                  :cook_time, :difficulty, :ingredients, :steps, :photo)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def add_fan
    @recipe.fans << current_user
  end

  def remove_fan
    @recipe.fans.delete(current_user)
  end
end

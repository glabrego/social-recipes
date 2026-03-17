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
      flash.now[:alert] = 'Warning! All fields are mandatory.'
      render :new
    end
  end

  def edit
    if current_user.id != @recipe.user_id
      redirect_to root_path, alert: 'You are not allowed to edit that recipe!'
    end
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      flash.now[:alert] = 'Warning! All fields are mandatory.'
      render :edit
    end
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

  def favorite
    if request.delete?
      remove_fan if @recipe.fans.exists?(current_user.id)
      redirect_to @recipe, notice: 'Receita removida das favoritas!'
    else
      add_fan unless @recipe.fans.exists?(current_user.id)
      redirect_to @recipe, notice: 'Receita adicionada as favoritas!'
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

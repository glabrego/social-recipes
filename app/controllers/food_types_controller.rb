class FoodTypesController < ApplicationController
  before_action :set_foodtype, only: :show
  before_action :authenticate_user!, except: :show

  def new
    @foodtype = FoodType.new
  end

  def create
    if current_user.admin?
      @foodtype = FoodType.create(foodtype_params)
      respond_with @foodtype
    else
      redirect_to root_path, alert: 'You are not allowed to create new food type!'
    end
  end

  def show
    @recipes = Recipe.where(food_type_id: params[:id])
  end

  private

  def foodtype_params
    params.require(:food_type)
          .permit(:name)
  end

  def set_foodtype
    @foodtype = FoodType.find(params[:id])
  end
end

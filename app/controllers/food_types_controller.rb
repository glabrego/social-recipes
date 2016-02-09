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
      redirect_to root_path
    end
  end

  def show
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
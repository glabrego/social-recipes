class FoodTypesController < ApplicationController
  before_action :set_foodtype, only: :show
  before_action :authenticate_user!, except: :show
  before_action :set_collections, only: :index

  def index
  end

  def new
    @foodtype = FoodType.new
  end

  def create
    if current_user.admin?
      @foodtype = FoodType.new(foodtype_params)
      if @foodtype.save
        redirect_to @foodtype
      else
        flash.now[:alert] = 'Add a dish type before saving.'
        render :new
      end
    else
      redirect_to root_path, alert: 'Only admins can add dish types.'
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

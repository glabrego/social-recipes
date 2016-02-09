class KitchensController < ApplicationController
  before_action :set_kitchen, only: :show
  before_action :authenticate_user!, except: :show

  def new
    @kitchen = Kitchen.new
  end

  def create
    if current_user.admin?
      @kitchen = Kitchen.create(kitchen_params)
      respond_with @kitchen
    else
      redirect_to root_path, alert: 'You are not allowed to create kitchens!'
    end
  end

  def show
    @recipes = Recipe.where(kitchen_id: params[:id])
  end

  private

  def kitchen_params
    params.require(:kitchen)
          .permit(:name)
  end

  def set_kitchen
    @kitchen = Kitchen.find(params[:id])
  end
end

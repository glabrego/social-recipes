class KitchensController < ApplicationController
  before_action :set_kitchen, only: [:show, :like]
  before_action :authenticate_user!, except: :show
  before_action :set_collections, only: :index

  def index
  end

  def new
    @kitchen = Kitchen.new
  end

  def create
    if current_user.admin?
      @kitchen = Kitchen.new(kitchen_params)
      if @kitchen.save
        redirect_to @kitchen
      else
        flash.now[:alert] = 'Add a cuisine name before saving.'
        render :new
      end
    else
      redirect_to root_path, alert: 'Only admins can add cuisines.'
    end
  end

  def show
    @recipes = Recipe.where(kitchen_id: params[:id])
  end

  def like
    if request.delete?
      @kitchen.likers.delete(current_user) if @kitchen.likers.exists?(current_user.id)
      redirect_to @kitchen, notice: 'Cuisine removed from your saved list.'
    else
      @kitchen.likers << current_user unless @kitchen.likers.exists?(current_user.id)
      redirect_to @kitchen, notice: 'Cuisine saved to your profile.'
    end
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

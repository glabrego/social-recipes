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
      @kitchen = Kitchen.create(kitchen_params)
      respond_with @kitchen
    else
      redirect_to root_path, alert: 'You are not allowed to create kitchens!'
    end
  end

  def show
    @recipes = Recipe.where(kitchen_id: params[:id])
  end

  def like
    unless @kitchen.likers.exists?(current_user.id)
      @kitchen.likers << current_user
      @kitchen.save
      redirect_to @kitchen, notice: 'Cozinha adicionada as favoritas!'
    else
      @kitchen.likers.delete(current_user)
      @kitchen.save
      redirect_to @kitchen, notice: 'Cozinha removida das favoritas!'
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

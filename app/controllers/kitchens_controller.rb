class KitchensController < ApplicationController
  before_action :set_kitchen, only: :show
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @kitchen = Kitchen.new
  end

  def create
    if current_user.admin?
      @kitchen = Kitchen.create(kitchen_params)
      respond_with @kitchen
    else
      redirect_to root_path
    end
  end

  def show
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

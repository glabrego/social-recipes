class KitchensController < ApplicationController
  before_action :set_kitchen, only: :show
  def new
    @kitchen = Kitchen.new
  end

  def create
    @kitchen = Kitchen.create(kitchen_params)
    respond_with @kitchen
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

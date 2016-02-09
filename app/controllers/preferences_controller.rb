class PreferencesController < ApplicationController
  before_action :set_preference, only: :show
  before_action :authenticate_user!, except: :show

  def new
    @preference = Preference.new
  end

  def create
    if current_user.admin?
      @preference = Preference.create(preference_params)
      respond_with @preference
    else
      redirect_to root_path, alert: 'You are not allowed to create preferences!'
    end
  end

  def show
    @recipes = Recipe.where(preference_id: params[:id])
  end

  private

  def preference_params
    params.require(:preference)
          .permit(:title)
  end

  def set_preference
    @preference = Preference.find(params[:id])
  end
end

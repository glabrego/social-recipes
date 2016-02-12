require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html
  protect_from_forgery with: :exception

  def set_collections
    @kitchens = Kitchen.all
    @food_types = FoodType.all
    @preferences = Preference.all
    @recipes = Recipe.all
  end
end

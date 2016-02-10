class HomeController < ApplicationController
  before_action :set_collections, only: :index
  def index
    @favorites = Recipe.most_favorites.first(10)
    @recipes = Recipe.last(20) - @favorites
  end
end

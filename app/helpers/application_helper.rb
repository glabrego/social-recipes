module ApplicationHelper
  def recipe_image(recipe, options = {})
    return unless recipe.photo.attached?

    image_tag(url_for(recipe.photo), options)
  end
end

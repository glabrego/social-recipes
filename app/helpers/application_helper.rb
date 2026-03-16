module ApplicationHelper
  def recipe_image(recipe, options = {})
    return unless recipe.photo?

    image_tag(recipe.photo_url, options)
  end
end

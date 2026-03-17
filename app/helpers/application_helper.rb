module ApplicationHelper
  def recipe_visual(recipe, options = {})
    css_class = options.delete(:class)

    if recipe.photo.attached?
      image_tag(url_for(recipe.photo), options.merge(class: css_class))
    else
      content_tag(:div, recipe.name.to_s.first(2).upcase, class: [css_class, 'recipe-visual--placeholder'].compact.join(' '))
    end
  end

  def saved_count_label(count)
    "#{count} #{'save'.pluralize(count)}"
  end
end

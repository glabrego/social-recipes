kitchen = Kitchen.find_or_create_by!(name: 'Japonesa')
food_type = FoodType.find_or_create_by!(name: 'Salgado')
preference = Preference.find_or_create_by!(title: 'Sem lactose')

admin = User.find_or_initialize_by(email: 'admin@socialrecipes.local')
admin.assign_attributes(
  name: 'Social Recipes Admin',
  location: 'Sao Paulo',
  twitter: 'socialrecipes',
  facebook: 'socialrecipes',
  password: 'rubyonrails',
  password_confirmation: 'rubyonrails',
  admin: true
)
admin.save!

Recipe.find_or_create_by!(name: 'Temaki de Salmao Completo') do |recipe|
  recipe.kitchen = kitchen
  recipe.food_type = food_type
  recipe.preference = preference
  recipe.user = admin
  recipe.servings = 4
  recipe.cook_time = 45
  recipe.difficulty = 'Medio'
  recipe.ingredients = 'Salmao, alga, cream cheese e cebolinha.'
  recipe.steps = 'Corte a alga, monte o recheio e enrole o temaki.'
end

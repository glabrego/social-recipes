require 'rails_helper'

feature 'User creates recipes' do
  scenario 'successfully' do
    user = FactoryBot.create(:user)
    food_type = FactoryBot.create(:food_type)
    kitchen = FactoryBot.create(:kitchen)
    preference = FactoryBot.create(:preference)
    recipe = FactoryBot.build(:recipe)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    visit new_recipe_path

    fill_in 'Recipe title', with: recipe.name
    select kitchen.name, from: 'Cuisine'
    select food_type.name, from: 'Dish type'
    select preference.title, from: 'Dietary preference'
    fill_in 'Serves', with: recipe.servings
    fill_in 'Cooking time', with: recipe.cook_time
    select  recipe.difficulty, from: 'Difficulty'
    fill_in 'Ingredients', with: recipe.ingredients
    fill_in 'Instructions', with: recipe.steps

    click_on 'Publish recipe'

    expect(page).to have_content recipe.name
    expect(page).to have_content kitchen.name
    expect(page).to have_content food_type.name
    expect(page).to have_content preference.title
    expect(page).to have_content recipe.servings
    expect(page).to have_content recipe.cook_time
    expect(page).to have_content recipe.difficulty
    expect(page).to have_content recipe.ingredients
    expect(page).to have_content recipe.steps
  end

  scenario 'invalid data' do
    user = FactoryBot.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    visit new_recipe_path

    click_on 'Publish recipe'

    expect(page).to have_content 'Please complete every field before publishing your recipe.'
  end
end

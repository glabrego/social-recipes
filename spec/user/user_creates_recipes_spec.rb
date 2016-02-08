require 'rails_helper'

feature 'User creates recipes' do
  scenario 'successfully' do
    user = FactoryGirl.build(:user)
    food_type = FactoryGirl.build(:food_type)
    kitchen = FactoryGirl.build(:kitchen)
    preference = FactoryGirl.build(:preference)
    recipe = FactoryGirl.build(:recipe)

    visit new_recipe_path

    fill_in 'Name', with: recipe.name
    select kitchen.name, from: 'Kitchen'
    select food_type.name, from: 'Food type'
    select preference.title, from: 'Preference'
    fill_in 'Servings', with: recipe.servings
    fill_in 'Cook time', with: recipe.cook_time
    select  recipe.difficulty, from: 'Difficulty'
    fill_in 'Ingredients', with: recipe.ingredients
    fill_in 'Steps', with: recipe.steps

    click_on 'Criar Receita'

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
end

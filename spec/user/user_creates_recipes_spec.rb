require 'rails_helper'

feature 'User creates recipes' do
  scenario 'successfully' do
    user = FactoryGirl.build(:user)
    food_type = FactoryGirl.build(:food_type)
    kitchen = FactoryGirl.build(:kitchen)
    preference = FactoryGirl.build(:preference)
    recipe = FactoryGirl.build(:recipe)

    visit new_recipe_path

    fill_in 'name', with: recipe.name
    fill_in 'kitchen', with: kitchen.name
    fill_in 'food type', with: food_type.name
    fill_in 'preference', with: preference.title
    fill_in 'servings', with: recipe.servings
    fill_in 'cook time', with: recipe.cook_time
    fill_in 'difficulty', with: recipe.difficulty
    fill_in 'ingredients', with: recipe.ingredients
    fill_in 'steps', with: recipe.steps

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

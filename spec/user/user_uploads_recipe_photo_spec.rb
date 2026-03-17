require 'rails_helper'

feature 'User uploads a recipe photo' do
  scenario 'successfully' do
    user = FactoryBot.create(:user)
    kitchen = FactoryBot.create(:kitchen)
    food_type = FactoryBot.create(:food_type)
    preference = FactoryBot.create(:preference)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit new_recipe_path

    fill_in 'Name', with: 'Temaki especial'
    select kitchen.name, from: 'recipe_kitchen_id'
    select food_type.name, from: 'recipe_food_type_id'
    select preference.title, from: 'recipe_preference_id'
    fill_in 'Servings', with: 2
    fill_in 'Cook time', with: 15
    select 'Médio', from: 'recipe_difficulty'
    fill_in 'Ingredients', with: 'Salmão e arroz'
    fill_in 'Steps', with: 'Monte o temaki'
    attach_file 'Photo', Rails.root.join('spec/fixtures/files/recipe-photo.svg')

    click_on 'Criar Receita'

    expect(page).to have_selector("img[alt='Temaki especial']")
    expect(Recipe.last.photo).to be_attached
  end
end

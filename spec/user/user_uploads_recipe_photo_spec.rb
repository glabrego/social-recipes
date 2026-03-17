require 'rails_helper'

feature 'User uploads a recipe photo' do
  let(:original_photo_path) { Rails.root.join('spec/fixtures/files/recipe-photo.svg') }
  let(:replacement_photo_path) { Rails.root.join('spec/fixtures/files/recipe-photo-replacement.svg') }

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

  scenario 'and keeps the existing photo when updating recipe details only' do
    user = FactoryBot.create(:user, admin: false)
    recipe = FactoryBot.create(:recipe, user: user)
    recipe.photo.attach(io: File.open(original_photo_path), filename: 'recipe-photo.svg',
                        content_type: 'image/svg+xml')
    original_blob_id = recipe.photo.blob_id

    login_user(user)

    visit edit_recipe_path(recipe)
    fill_in 'Name', with: 'Temaki atualizado'

    click_on 'Salvar Receita'

    expect(page).to have_content('Temaki atualizado')
    expect(recipe.reload.photo).to be_attached
    expect(recipe.photo.blob_id).to eq(original_blob_id)
  end

  scenario 'and replaces the existing photo when uploading a new one on edit' do
    user = FactoryBot.create(:user, admin: false)
    recipe = FactoryBot.create(:recipe, user: user)
    recipe.photo.attach(io: File.open(original_photo_path), filename: 'recipe-photo.svg',
                        content_type: 'image/svg+xml')
    original_blob_id = recipe.photo.blob_id

    login_user(user)

    visit edit_recipe_path(recipe)
    fill_in 'Name', with: 'Temaki com nova foto'
    attach_file 'Photo', replacement_photo_path

    click_on 'Salvar Receita'

    expect(page).to have_content('Temaki com nova foto')
    expect(recipe.reload.photo).to be_attached
    expect(recipe.photo.blob_id).not_to eq(original_blob_id)
  end
end

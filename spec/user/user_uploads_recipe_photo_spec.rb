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
    click_button 'Log in'

    visit new_recipe_path

    fill_in 'Recipe title', with: 'Special temaki'
    select kitchen.name, from: 'recipe_kitchen_id'
    select food_type.name, from: 'recipe_food_type_id'
    select preference.title, from: 'recipe_preference_id'
    fill_in 'Serves', with: 2
    fill_in 'Cooking time', with: 15
    select 'Medium', from: 'recipe_difficulty'
    fill_in 'Ingredients', with: 'Salmon and rice'
    fill_in 'Instructions', with: 'Assemble the temaki'
    attach_file 'Photo', Rails.root.join('spec/fixtures/files/recipe-photo.svg')

    click_on 'Publish recipe'

    expect(page).to have_selector("img[alt='Special temaki']")
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
    fill_in 'Recipe title', with: 'Updated temaki'

    click_on 'Save changes'

    expect(page).to have_content('Updated temaki')
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
    fill_in 'Recipe title', with: 'Temaki with a new photo'
    attach_file 'Photo', replacement_photo_path

    click_on 'Save changes'

    expect(page).to have_content('Temaki with a new photo')
    expect(recipe.reload.photo).to be_attached
    expect(recipe.photo.blob_id).not_to eq(original_blob_id)
  end
end

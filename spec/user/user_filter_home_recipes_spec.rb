require 'rails_helper'

feature 'User filter recipes at homepage' do
  scenario 'successfully' do
    food_type = FactoryBot.create(:food_type)
    food_type2 = FactoryBot.create(:food_type, name: 'Doce')
    kitchen = FactoryBot.create(:kitchen)
    kitchen2 = FactoryBot.create(:kitchen, name: 'Italiana')
    preference = FactoryBot.create(:preference)
    preference2 = FactoryBot.create(:preference, title: 'Vegetariana')
    FactoryBot.create(:recipe)

    visit root_path

    expect(page).to have_content food_type.name
    expect(page).to have_content food_type2.name
    expect(page).to have_content kitchen.name
    expect(page).to have_content kitchen2.name
    expect(page).to have_content preference.title
    expect(page).to have_content preference2.title
  end

  scenario 'and see filtered food_type content' do
    food_type = FactoryBot.create(:food_type, name: 'Doce')
    recipe = FactoryBot.create(:recipe)
    recipe2 = FactoryBot.create(:recipe, name: 'Torta', food_type_id: food_type.id)

    visit root_path

    click_on food_type.name

    expect(page).not_to have_content recipe.name
    expect(page).to have_content recipe2.name
  end

  scenario 'and see filtered kitchen content' do
    kitchen = FactoryBot.create(:kitchen, name: 'Italiana')
    recipe = FactoryBot.create(:recipe)
    recipe2 = FactoryBot.create(:recipe, name: 'Miojo', kitchen_id: kitchen.id)

    visit root_path

    click_on kitchen.name

    expect(page).not_to have_content recipe.name
    expect(page).to have_content recipe2.name
  end

  scenario 'and see filtered preference content' do
    preference = FactoryBot.create(:preference, title: 'Vegetariana')
    recipe = FactoryBot.create(:recipe)
    recipe2 = FactoryBot.create(:recipe, name: 'Strogonoff', preference_id: preference.id)

    visit root_path

    click_on preference.title

    expect(page).not_to have_content recipe.name
    expect(page).to have_content recipe2.name
  end
end

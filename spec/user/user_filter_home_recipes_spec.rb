require 'rails_helper'

feature 'User filter recipes at homepage' do
  scenario 'successfully' do
    food_type = FactoryGirl.create(:food_type)
    food_type2 = FactoryGirl.create(:food_type, name: 'Doce')
    kitchen = FactoryGirl.create(:kitchen)
    kitchen2 = FactoryGirl.create(:kitchen, name: 'Italiana')
    preference = FactoryGirl.create(:preference)
    preference2 = FactoryGirl.create(:preference, title: 'Vegetariana')
    recipe = FactoryGirl.create(:recipe)

    visit root_path

    expect(page).to have_content food_type.name
    expect(page).to have_content food_type2.name
    expect(page).to have_content kitchen.name
    expect(page).to have_content kitchen2.name
    expect(page).to have_content preference.title
    expect(page).to have_content preference2.title
  end

  scenario 'and see filtered food_type content' do
    food_type = FactoryGirl.create(:food_type, name: 'Doce')
    recipe = FactoryGirl.create(:recipe)
    recipe2 = FactoryGirl.create(:recipe, name:'Torta', food_type_id: food_type.id)

    visit root_path

    click_on food_type.name

    expect(page).not_to have_content recipe.name
    expect(page).to have_content recipe2.name
  end

  scenario 'and see filtered kitchen content' do
    kitchen = FactoryGirl.create(:kitchen, name: 'Italiana')
    recipe = FactoryGirl.create(:recipe)
    recipe2 = FactoryGirl.create(:recipe, name: 'Miojo', kitchen_id: kitchen.id)

    visit root_path

    click_on kitchen.name

    expect(page).not_to have_content recipe.name
    expect(page).to have_content recipe2.name
  end

  scenario 'and see filtered preference content' do
    preference = FactoryGirl.create(:preference, title: 'Vegetariana')
    recipe = FactoryGirl.create(:recipe)
    recipe2 = FactoryGirl.create(:recipe, name: 'Strogonoff', preference_id: preference.id)

    visit root_path

    click_on preference.title

    expect(page).not_to have_content recipe.name
    expect(page).to have_content recipe2.name
  end
end

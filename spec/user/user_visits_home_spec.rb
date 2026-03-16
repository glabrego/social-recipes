require 'rails_helper'

feature 'Home show recipes' do
  scenario 'successfully' do
    recipe = FactoryBot.create(:recipe)

    visit root_path

    expect(page).to have_content recipe.name
    expect(page).to have_content recipe.kitchen.name
    expect(page).to have_content recipe.food_type.name
    expect(page).to have_content recipe.preference.title
    expect(page).to have_content recipe.difficulty
  end

  scenario 'and visit recipes details' do
    recipe = FactoryBot.create(:recipe)

    visit root_path

    click_on recipe.name

    expect(page).to have_content recipe.ingredients
    expect(page).to have_content recipe.steps
  end
end

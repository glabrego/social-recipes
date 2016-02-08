require 'rails_helper'

feature 'Home show recipes' do
  scenario 'successfully' do
    user = FactoryGirl.create(:user)
    food_type = FactoryGirl.create(:food_type)
    kitchen = FactoryGirl.create(:kitchen)
    preference = FactoryGirl.create(:preference)
    recipe = FactoryGirl.create(:recipe)

    visit root_path

    expect(page).to have_content recipe.name
    expect(page).to have_content kitchen.name
    expect(page).to have_content food_type.name
    expect(page).to have_content preference.title
    expect(page).to have_content recipe.difficulty
  end

  scenario 'and visit recipes details' do
    user = FactoryGirl.create(:user)
    food_type = FactoryGirl.create(:food_type)
    kitchen = FactoryGirl.create(:kitchen)
    preference = FactoryGirl.create(:preference)
    recipe = FactoryGirl.create(:recipe)

    visit root_path

    click_on recipe.name

    expect(page).to have_content recipe.ingredients
    expect(page).to have_content recipe.steps
  end
end

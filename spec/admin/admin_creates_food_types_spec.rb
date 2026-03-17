require 'rails_helper'

feature 'Admin creates food types' do
  scenario 'successfully' do
    food_type = FactoryBot.build(:food_type)

    login_admin

    visit new_food_type_path

    fill_in 'Dish type name', with: food_type.name

    click_on 'Add dish type'

    expect(page).to have_content food_type.name
  end

  scenario 'and not admin users cannot creates new food types' do
    food_type = FactoryBot.build(:food_type)

    login_user

    visit new_food_type_path

    fill_in 'Dish type name', with: food_type.name

    click_on 'Add dish type'

    expect(current_path). to eq root_path
  end
end

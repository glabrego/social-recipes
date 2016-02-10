require 'rails_helper'

feature 'Admin creates food types' do
  scenario 'successfully' do
    food_type = FactoryGirl.build(:food_type)

    login_admin

    visit new_food_type_path

    fill_in 'Name', with: food_type.name

    click_on 'Criar Tipo de Comida'

    expect(page).to have_content food_type.name
  end

  scenario 'and not admin users cannot creates new food types' do
    food_type = FactoryGirl.build(:food_type)

    login_user

    visit new_food_type_path

    fill_in 'Name', with: food_type.name

    click_on 'Criar Tipo de Comida'

    expect(current_path). to eq root_path
  end
end

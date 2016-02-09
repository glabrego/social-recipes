require 'rails_helper'

feature 'Admin creates food types' do
  scenario 'successfully' do
    user = FactoryGirl.create(:user)
    food_type = FactoryGirl.build(:food_type)

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    visit new_food_type_path

    fill_in 'Name', with: food_type.name

    click_on 'Criar Tipo de Comida'

    expect(page).to have_content food_type.name
  end

  scenario 'and not admin users cannot creates new food types' do
    user = FactoryGirl.create(:user, admin: false)
    food_type = FactoryGirl.build(:food_type)

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    visit new_food_type_path

    fill_in 'Name', with: food_type.name

    click_on 'Criar Tipo de Comida'

    expect(current_path). to eq root_path
  end
end

require 'rails_helper'

feature 'Admin creates new kitchens' do
  scenario 'successfully' do
    kitchen = FactoryGirl.build(:kitchen)

    login_admin

    visit new_kitchen_path

    fill_in 'Name', with: kitchen.name

    click_on 'Criar Cozinha'

    expect(page).to have_content kitchen.name
  end

  scenario 'and not admin users cannot creates new kitchens' do
    kitchen = FactoryGirl.build(:kitchen)

    login_user

    visit new_kitchen_path

    fill_in 'Name', with: kitchen.name

    click_on 'Criar Cozinha'

    expect(current_path).to eq root_path
  end
end

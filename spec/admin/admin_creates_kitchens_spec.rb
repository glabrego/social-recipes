require 'rails_helper'

feature 'Admin creates new kitchens' do
  scenario 'successfully' do
    kitchen = FactoryBot.build(:kitchen)

    login_admin

    visit new_kitchen_path

    fill_in 'Cuisine name', with: kitchen.name

    click_on 'Add cuisine'

    expect(page).to have_content kitchen.name
  end

  scenario 'and not admin users cannot creates new kitchens' do
    kitchen = FactoryBot.build(:kitchen)

    login_user

    visit new_kitchen_path

    fill_in 'Cuisine name', with: kitchen.name

    click_on 'Add cuisine'

    expect(current_path).to eq root_path
  end
end

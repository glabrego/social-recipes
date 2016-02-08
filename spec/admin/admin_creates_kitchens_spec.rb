require 'rails_helper'

feature 'Admin creates new kitchens' do
  scenario 'successfully' do

    user = FactoryGirl.create(:user)
    kitchen = FactoryGirl.build(:kitchen)

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    visit new_kitchen_path

    fill_in 'Name', with: kitchen.name

    click_on 'Criar Cozinha'

    expect(page).to have_content kitchen.name
  end

  scenario 'and not admin users cannot creates new kitchens' do
    user = FactoryGirl.create(:user, admin: false)
    kitchen = FactoryGirl.build(:kitchen)

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    visit new_kitchen_path

    fill_in 'Name', with: kitchen.name

    click_on 'Criar Cozinha'

    expect(current_path).to eq root_path
  end
end

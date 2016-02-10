require 'rails_helper'

feature 'Admin creates preferences' do
  scenario 'successfully' do
    preference = FactoryGirl.build(:preference)

    login_admin

    visit new_preference_path

    fill_in 'Title', with: preference.title

    click_on 'Criar Preferência'

    expect(page).to have_content preference.title
  end

  scenario 'and not admin users cannot creates new food types' do
    preference = FactoryGirl.build(:preference)

    login_user

    visit new_preference_path

    fill_in 'Title', with: preference.title

    click_on 'Criar Preferência'

    expect(current_path). to eq root_path
  end
end

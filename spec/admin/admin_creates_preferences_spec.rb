require 'rails_helper'

feature 'Admin creates preferences' do
  scenario 'successfully' do
    user = FactoryGirl.create(:user)
    preference = FactoryGirl.build(:preference)

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    visit new_preference_path

    fill_in 'Title', with: preference.title

    click_on 'Criar Preferência'

    expect(page).to have_content preference.title
  end

  scenario 'and not admin users cannot creates new food types' do
    user = FactoryGirl.create(:user, admin: false)
    preference = FactoryGirl.build(:preference)

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    visit new_preference_path

    fill_in 'Title', with: preference.title

    click_on 'Criar Preferência'

    expect(current_path). to eq root_path
  end
end

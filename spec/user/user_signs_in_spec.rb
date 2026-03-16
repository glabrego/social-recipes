require 'rails_helper'

feature 'User signs in' do
  scenario 'successfully' do
    user = FactoryBot.create(:user, admin: false)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    expect(current_path).to eq root_path
    expect(page).to have_content(user.email)
  end
end

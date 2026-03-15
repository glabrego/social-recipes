require 'rails_helper'

feature 'User keep your own profile' do
  scenario 'successfully' do
    user = FactoryBot.create(:user, admin: false)

    login_user(user)

    visit user_path(user)

    expect(page).to have_content 'Guilherme Labrego'
    expect(page).to have_content 'São Paulo'
  end
  scenario 'and edits profile' do
    user = FactoryBot.create(:user, admin: false)

    login_user(user)

    visit edit_user_registration_path(user)

    fill_in 'Name', with: 'João Labrego'
    fill_in 'Current password', with: user.password

    click_on 'Update'

    visit user_path(user)

    expect(page).to have_content 'João Labrego'
    expect(page).to have_content 'São Paulo'
  end
end

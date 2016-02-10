require 'rails_helper'

feature 'User keep your own profile' do
  scenario 'successfully' do
    user = FactoryGirl.create(:user, admin: false)

    login_user(user)

    visit user_path(user)

    expect(page).to have_content 'Guilherme Labrego'
    expect(page).to have_content 'São Paulo'
  end
end

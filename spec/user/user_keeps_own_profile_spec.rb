require 'rails_helper'

feature 'User keep your own profile' do
  scenario 'successfully' do
    login_user

    visit user_path

    expect(page).to have_content 'Guilherme Labrego'
    expect(page).to have_content 'São Paulo'
  end
end

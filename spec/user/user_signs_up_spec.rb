require 'rails_helper'

feature 'User signs up' do
  scenario 'successfully' do
    visit new_user_registration_path

    fill_in 'Name', with: 'Ana Paula'
    fill_in 'Location', with: 'Sao Paulo'
    fill_in 'Twitter', with: 'anapaula'
    fill_in 'Facebook', with: 'anapaula'
    fill_in 'Email', with: 'ana@example.com'
    fill_in 'Password', with: 'rubyonrails'
    fill_in 'Password confirmation', with: 'rubyonrails'

    click_on 'Sign up'

    user = User.find_by(email: 'ana@example.com')

    expect(user).not_to be_nil
    expect(user.name).to eq 'Ana Paula'
    expect(user.location).to eq 'Sao Paulo'
    expect(user.twitter).to eq 'anapaula'
    expect(user.facebook).to eq 'anapaula'
    expect(page).to have_content(user.email)
  end
end

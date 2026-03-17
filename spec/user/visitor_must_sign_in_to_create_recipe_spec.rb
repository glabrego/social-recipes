require 'rails_helper'

feature 'Visitor must sign in to create recipes' do
  scenario 'when opening the new recipe page' do
    visit new_recipe_path

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Log in to keep your saved recipes close.'
  end
end

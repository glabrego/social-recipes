require 'rails_helper'

feature 'User now can destroy your own recipes' do
  scenario 'succesfully' do
    user = FactoryGirl.create(:user, admin: false)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    recipe = FactoryGirl.create(:recipe, user_id: user.id)

    visit recipe_path(recipe)

    click_on 'Excluir'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Recipe destroyed.'
  end
end

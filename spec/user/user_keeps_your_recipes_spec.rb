require 'rails_helper'

feature 'User keeps your recipes' do
  scenario 'successfully' do
    user = FactoryBot.create(:user, admin: false)
    user2 = FactoryBot.create(:user, email: 'giga@gmail.com', admin: false)
    recipe = FactoryBot.create(:recipe, user_id: user.id)
    recipe2 = FactoryBot.create(:recipe, user_id: user2.id)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    visit edit_recipe_path(recipe)
    click_on 'Salvar Receita'
    expect(page).to have_content recipe.name

    visit edit_recipe_path(recipe2)
    expect(current_path).to eq root_path
  end
end

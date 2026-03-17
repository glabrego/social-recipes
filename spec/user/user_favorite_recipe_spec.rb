require 'rails_helper'
feature 'User favorite recipe' do
  scenario 'and favorite it' do
    recipe = FactoryBot.create(:recipe)

    login_user

    visit recipe_path(recipe)
    click_on 'Save recipe'

    expect(page).to have_content('Recipe saved to your collection.')
    expect(page).to have_content('1 save')
  end

  scenario 'and remove from favorites' do
    recipe = FactoryBot.create(:recipe)

    login_user

    visit recipe_path(recipe)

    click_on 'Save recipe'
    click_on 'Remove from saved'

    expect(page).to have_content('Recipe removed from your saved recipes.')
    expect(page).to have_content('0 saves')
  end

  scenario 'and see users favorites' do
    recipe = FactoryBot.create(:recipe)

    user = FactoryBot.create(:user, admin: false)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    visit recipe_path(recipe)
    click_on 'Save recipe'

    visit user_path(user)

    expect(page).to have_content(recipe.name)
  end

  scenario 'and see favorites at home' do
    recipe = FactoryBot.create(:recipe)

    user = FactoryBot.create(:user, admin: false)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    visit recipe_path(recipe)
    click_on 'Save recipe'

    visit root_path

    expect(page).to have_content(recipe.name)
  end
end

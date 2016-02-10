require 'rails_helper'
feature 'User favorite recipe' do
  scenario 'and favorite it' do
    recipe = FactoryGirl.create(:recipe)

    login_user

    visit recipe_path(recipe)
    click_on 'Favoritar'

    expect(page).to have_content("Receita adicionada as favoritas!")
    expect(page).to have_content("1 Favoritaram")
  end

  scenario 'and remove from favorites' do
    recipe = FactoryGirl.create(:recipe)

    login_user

    visit recipe_path(recipe)

    click_on 'Favoritar'
    click_on 'Remover Favorita'

    expect(page).to have_content("Receita removida das favoritas!")
    expect(page).to have_content("0 Favoritaram")
  end

  scenario 'and see users favorites' do
    recipe = FactoryGirl.create(:recipe)

    user = FactoryGirl.create(:user, admin: false)

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    visit recipe_path(recipe)
    click_on 'Favoritar'

    visit user_path(user)

    expect(page).to have_content(recipe.name)
  end

  scenario 'and see favorites at home' do
    recipe = FactoryGirl.create(:recipe)

    user = FactoryGirl.create(:user, admin: false)

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    visit recipe_path(recipe)
    click_on 'Favoritar'

    visit root_path

    expect(page).to have_content(recipe.name)
  end
end

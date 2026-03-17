require 'rails_helper'

feature 'User updates own recipe' do
  scenario 'successfully' do
    user = FactoryBot.create(:user, admin: false)
    recipe = FactoryBot.create(:recipe, user: user)

    login_user(user)

    visit edit_recipe_path(recipe)

    fill_in 'Recipe title', with: 'Special temaki'
    fill_in 'Serves', with: '6'
    fill_in 'Ingredients', with: 'Salmon, rice, and scallions.'
    fill_in 'Instructions', with: 'Assemble the filling and finish each temaki just before serving.'

    click_on 'Save changes'

    expect(page).to have_content 'Special temaki'
    expect(page).to have_content '6'
    expect(page).to have_content 'Salmon, rice, and scallions.'
    expect(page).to have_content 'Assemble the filling and finish each temaki just before serving.'
  end
end

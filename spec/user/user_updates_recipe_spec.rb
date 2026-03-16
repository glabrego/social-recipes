require 'rails_helper'

feature 'User updates own recipe' do
  scenario 'successfully' do
    user = FactoryBot.create(:user, admin: false)
    recipe = FactoryBot.create(:recipe, user: user)

    login_user(user)

    visit edit_recipe_path(recipe)

    fill_in 'Name', with: 'Temaki Especial'
    fill_in 'Servings', with: '6'
    fill_in 'Ingredients', with: 'Salmao, arroz e cebolinha.'
    fill_in 'Steps', with: 'Monte o recheio e finalize o temaki.'

    click_on 'Salvar Receita'

    expect(page).to have_content 'Temaki Especial'
    expect(page).to have_content '6'
    expect(page).to have_content 'Salmao, arroz e cebolinha.'
    expect(page).to have_content 'Monte o recheio e finalize o temaki.'
  end
end

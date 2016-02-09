require 'rails_helper'

feature 'User keeps your recipes' do
  scenario 'successfully' do
    user = FactoryGirl.create(:user, admin: false)
    user2 = FactoryGirl.create(:user, email:'giga@gmail.com', admin: false)
    recipe = FactoryGirl.create(:recipe, user_id: user.id)
    recipe2 = FactoryGirl.create(:recipe, user_id: user2.id)
    food_type = FactoryGirl.build(:food_type)

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    visit edit_recipe_path(recipe)
    expect(page).to have_content recipe.name

    visit edit_recipe_path(recipe2)
    expect(current_path).to eq root_path
  end
end

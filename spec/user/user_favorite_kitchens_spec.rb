require 'rails_helper'

feature 'User favorite kitchen' do
  scenario 'successfully' do
    kitchen = FactoryGirl.create(:kitchen)

    login_user

    visit kitchen_path(kitchen)
    click_on 'Favoritar'

    expect(page).to have_content 'Cozinha adicionada as favoritas!'
  end

  scenario 'and remove favorited kitchen' do
    kitchen = FactoryGirl.create(:kitchen)

    login_user

    visit kitchen_path(kitchen)
    click_on 'Favoritar'
    click_on 'Remover Favorita'

    expect(page).to have_content 'Cozinha removida das favoritas!'
  end

  scenario 'and see users favorites' do
    kitchen = FactoryGirl.create(:kitchen)
    user = FactoryGirl.create(:user)

    login_user(user)

    visit kitchen_path(kitchen)
    click_on 'Favoritar'

    visit user_path(user)

    expect(page).to have_content(kitchen.name)
  end
end

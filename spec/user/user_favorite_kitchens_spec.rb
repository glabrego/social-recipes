require 'rails_helper'

feature 'User favorite kitchen' do
  scenario 'successfully' do
    kitchen = FactoryBot.create(:kitchen)

    login_user

    visit kitchen_path(kitchen)
    click_on 'Save cuisine'

    expect(page).to have_content 'Cuisine saved to your profile.'
  end

  scenario 'and remove favorited kitchen' do
    kitchen = FactoryBot.create(:kitchen)

    login_user

    visit kitchen_path(kitchen)
    click_on 'Save cuisine'
    click_on 'Remove from saved'

    expect(page).to have_content 'Cuisine removed from your saved list.'
  end

  scenario 'and see users favorites' do
    kitchen = FactoryBot.create(:kitchen)
    user = FactoryBot.create(:user)

    login_user(user)

    visit kitchen_path(kitchen)
    click_on 'Save cuisine'

    visit user_path(user)

    expect(page).to have_content(kitchen.name)
  end
end

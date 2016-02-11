require 'rails_helper'

feature 'User favorite kitchen' do
  scenario 'successfully' do
    kitchen = FactoryGirl.create(:kitchen)

    login_user

    visit kitchen_path(kitchen)
    click_on 'Favoritar'

    expect(page).to have_content 'Receita favoritada!'
  end
end

require 'rails_helper'

feature 'User filter recipes at homepage' do
  scenario 'successfully' do
    food_type = FactoryGirl.create(:food_type)
    food_type2 = FactoryGirl.create(:food_type, name: 'Doce')
    kitchen = FactoryGirl.create(:kitchen)
    kitchen2 = FactoryGirl.create(:kitchen, name: 'Italiana')
    preference = FactoryGirl.create(:preference)
    preference2 = FactoryGirl.create(:preference, title: 'Vegetariana')
    recipe = FactoryGirl.create(:recipe)

    visit root_path

    expect(page).to have_content food_type.name
    expect(page).to have_content food_type2.name
    expect(page).to have_content kitchen.name
    expect(page).to have_content kitchen2.name
    expect(page).to have_content preference.title
    expect(page).to have_content preference2.title  
  end
end

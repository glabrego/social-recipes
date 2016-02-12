require 'rails_helper'

feature 'User creates recipes' do
  scenario 'successfully' do
    recipes = %w(Arroz Feijão Batata Macarrão Strogonoff Sushi Salmão Empanada Torta
                 Lasana Pizza Esfiha Coxinha Rabanada Pudim Nuggets Sopa Café Pão Bolo)

    recipes.each do |name|
      FactoryGirl.create(:recipe, name: name)
    end

    visit root_path

    recipes.each do |name|
      expect(page).to have_content name
    end
  end
end

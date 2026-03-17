require 'rails_helper'

RSpec.describe 'Social actions', type: :request do
  let(:user) { FactoryBot.create(:user, admin: false) }

  before do
    sign_in user
  end

  describe 'recipe favorites' do
    let(:recipe) { FactoryBot.create(:recipe) }

    it 'adds a favorite only once even if the create endpoint is posted twice' do
      post favorite_recipe_path(recipe)
      post favorite_recipe_path(recipe)

      expect(response).to redirect_to(recipe_path(recipe))
      expect(recipe.reload.fans).to contain_exactly(user)
    end

    it 'keeps the favorite removed when the delete endpoint is called twice' do
      post favorite_recipe_path(recipe)

      delete favorite_recipe_path(recipe)
      delete favorite_recipe_path(recipe)

      expect(response).to redirect_to(recipe_path(recipe))
      expect(recipe.reload.fans).to be_empty
    end
  end

  describe 'kitchen likes' do
    let(:kitchen) { FactoryBot.create(:kitchen) }

    it 'adds a like only once even if the create endpoint is posted twice' do
      post like_kitchen_path(kitchen)
      post like_kitchen_path(kitchen)

      expect(response).to redirect_to(kitchen_path(kitchen))
      expect(kitchen.reload.likers).to contain_exactly(user)
    end

    it 'keeps the like removed when the delete endpoint is called twice' do
      post like_kitchen_path(kitchen)

      delete like_kitchen_path(kitchen)
      delete like_kitchen_path(kitchen)

      expect(response).to redirect_to(kitchen_path(kitchen))
      expect(kitchen.reload.likers).to be_empty
    end
  end
end

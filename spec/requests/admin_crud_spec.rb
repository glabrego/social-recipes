require 'rails_helper'

RSpec.describe 'Admin CRUD', type: :request do
  describe 'POST /kitchens' do
    let(:admin) { FactoryBot.create(:user) }
    let(:user) { FactoryBot.create(:user, admin: false) }

    it 'redirects unauthenticated users to sign in' do
      expect do
        post kitchens_path, params: { kitchen: { name: 'Brasileira' } }
      end.not_to change(Kitchen, :count)

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'rejects non-admin users' do
      sign_in user

      expect do
        post kitchens_path, params: { kitchen: { name: 'Brasileira' } }
      end.not_to change(Kitchen, :count)

      expect(response).to redirect_to(root_path)
    end

    it 're-renders the form for invalid admin submissions' do
      sign_in admin

      expect do
        post kitchens_path, params: { kitchen: { name: '' } }
      end.not_to change(Kitchen, :count)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Warning! All fields are mandatory.')
      expect(response.body).to include('Name')
    end
  end

  describe 'POST /food_types' do
    let(:admin) { FactoryBot.create(:user) }
    let(:user) { FactoryBot.create(:user, admin: false) }

    it 'redirects unauthenticated users to sign in' do
      expect do
        post food_types_path, params: { food_type: { name: 'Sobremesa' } }
      end.not_to change(FoodType, :count)

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'rejects non-admin users' do
      sign_in user

      expect do
        post food_types_path, params: { food_type: { name: 'Sobremesa' } }
      end.not_to change(FoodType, :count)

      expect(response).to redirect_to(root_path)
    end

    it 're-renders the form for invalid admin submissions' do
      sign_in admin

      expect do
        post food_types_path, params: { food_type: { name: '' } }
      end.not_to change(FoodType, :count)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Warning! All fields are mandatory.')
      expect(response.body).to include('Name')
    end
  end

  describe 'POST /preferences' do
    let(:admin) { FactoryBot.create(:user) }
    let(:user) { FactoryBot.create(:user, admin: false) }

    it 'redirects unauthenticated users to sign in' do
      expect do
        post preferences_path, params: { preference: { title: 'Sem Lactose' } }
      end.not_to change(Preference, :count)

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'rejects non-admin users' do
      sign_in user

      expect do
        post preferences_path, params: { preference: { title: 'Sem Lactose' } }
      end.not_to change(Preference, :count)

      expect(response).to redirect_to(root_path)
    end

    it 're-renders the form for invalid admin submissions' do
      sign_in admin

      expect do
        post preferences_path, params: { preference: { title: '' } }
      end.not_to change(Preference, :count)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Warning! All fields are mandatory.')
      expect(response.body).to include('Title')
    end
  end
end

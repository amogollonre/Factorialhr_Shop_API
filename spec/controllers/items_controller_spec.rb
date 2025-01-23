require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:category) { create(:category) }
  let(:valid_attributes) {
    { 
      category_id: category.id,
      name: 'Mountain Bike Pro',
      description: 'Professional mountain bike',
      base_price: 99.99
    }
  }

  let(:invalid_attributes) {
    { name: '' }
  }

  describe 'GET #index' do
    it 'returns a successful response' do
      create(:item, category: category)
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      item = create(:item, category: category)
      get :show, params: { id: item.id }
      expect(response).to be_successful
    end

    it 'returns 404 for non-existent item' do
      get :show, params: { id: 999 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Item' do
        expect {
          post :create, params: { item: valid_attributes }
        }.to change(Item, :count).by(1)
      end

      it 'renders a JSON response with the new item' do
        post :create, params: { item: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Item' do
        expect {
          post :create, params: { item: invalid_attributes }
        }.to change(Item, :count).by(0)
      end

      it 'renders a JSON response with errors' do
        post :create, params: { item: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
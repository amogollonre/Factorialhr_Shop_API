require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:valid_attributes) { 
    { name: 'Mountain Bikes', description: 'All mountain and trail bikes' }
  }

  let(:invalid_attributes) {
    { name: '' }
  }

  describe 'GET #index' do
    it 'returns a successful response' do
      Category.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      category = Category.create! valid_attributes
      get :show, params: { id: category.id }
      expect(response).to be_successful
    end

    it 'returns 404 for non-existent category' do
      get :show, params: { id: 999 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Category' do
        expect {
          post :create, params: { category: valid_attributes }
        }.to change(Category, :count).by(1)
      end

      it 'renders a JSON response with the new category' do
        post :create, params: { category: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Category' do
        expect {
          post :create, params: { category: invalid_attributes }
        }.to change(Category, :count).by(0)
      end

      it 'renders a JSON response with errors' do
        post :create, params: { category: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

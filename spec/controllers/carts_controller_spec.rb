require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:valid_attributes) {
    { user_id: 1, status: 'pending' }
  }

  let(:invalid_attributes) {
    { user_id: nil }
  }

  describe 'GET #index' do
    it 'returns a successful response' do
      create(:cart)
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      cart = create(:cart)
      get :show, params: { id: cart.id }
      expect(response).to be_successful
    end

    it 'returns 404 for non-existent cart' do
      get :show, params: { id: 999 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Cart' do
        expect {
          post :create, params: { cart: valid_attributes }
        }.to change(Cart, :count).by(1)
      end

      it 'renders a JSON response with the new cart' do
        post :create, params: { cart: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Cart' do
        expect {
          post :create, params: { cart: invalid_attributes }
        }.to change(Cart, :count).by(0)
      end

      it 'renders a JSON response with errors' do
        post :create, params: { cart: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
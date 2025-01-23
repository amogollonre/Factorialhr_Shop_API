require 'rails_helper'

RSpec.describe CartItemsController, type: :controller do
  let(:cart) { create(:cart) }
  let(:item) { create(:item) }
  let(:valid_attributes) { 
    { 
      cart_id: cart.id, 
      item_id: item.id, 
      selected_options: { "color": "red" }, 
      final_price: 99.99 
    }
  }

  let(:invalid_attributes) { 
    { 
      cart_id: nil,
      selected_options: {}
    }
  }

  describe 'GET #index' do
    it 'returns a successful response' do
      cart_item = create(:cart_item, 
        cart: cart, 
        item: item, 
        selected_options: { "color": "red" }
      )
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new CartItem' do
        expect {
          post :create, params: { cart_item: valid_attributes }
        }.to change(CartItem, :count).by(1)
      end

      it 'renders a JSON response with the new cart_item' do
        post :create, params: { cart_item: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new CartItem' do
        expect {
          post :create, params: { cart_item: invalid_attributes }
        }.to change(CartItem, :count).by(0)
      end
    end
  end
end
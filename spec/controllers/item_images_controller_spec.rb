require 'rails_helper'

RSpec.describe ItemImagesController, type: :controller do
  let(:item) { create(:item) }
  let(:valid_attributes) {
    {
      item_id: item.id,
      url: "http://example.com/image.jpg",
      alt_text: "Test Image"
    }
  }

  let(:invalid_attributes) {
    { url: "" }
  }

  describe 'GET #index' do
    it 'returns a successful response' do
      create(:item_image, item: item)
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new ItemImage' do
        expect {
          post :create, params: { item_image: valid_attributes }
        }.to change(ItemImage, :count).by(1)
      end

      it 'renders a JSON response with the new image' do
        post :create, params: { item_image: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new ItemImage' do
        expect {
          post :create, params: { item_image: invalid_attributes }
        }.to change(ItemImage, :count).by(0)
      end
    end
  end
end
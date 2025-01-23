require 'rails_helper'

RSpec.describe OptionImagesController, type: :controller do
  let(:characteristic_option) { create(:characteristic_option) }
  let(:valid_attributes) {
    {
      characteristic_option_id: characteristic_option.id,
      url: 'http://example.com/image.jpg',
      alt_text: 'Test Image'
    }
  }

  let(:invalid_attributes) {
    { url: '' }
  }

  describe 'GET #index' do
    it 'returns a successful response' do
      create(:option_image, characteristic_option: characteristic_option)
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new OptionImage' do
        expect {
          post :create, params: { option_image: valid_attributes }
        }.to change(OptionImage, :count).by(1)
      end

      it 'renders a JSON response with the new image' do
        post :create, params: { option_image: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new OptionImage' do
        expect {
          post :create, params: { option_image: invalid_attributes }
        }.to change(OptionImage, :count).by(0)
      end
    end
  end
end
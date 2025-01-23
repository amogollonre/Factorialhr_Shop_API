require 'rails_helper'

RSpec.describe CharacteristicOptionsController, type: :controller do
  let(:characteristic) { create(:characteristic) }
  let(:valid_attributes) {
    {
      characteristic_id: characteristic.id,
      name: 'Red Color',
      price_adjustment: 10.00
    }
  }

  let(:invalid_attributes) {
    { name: '' }
  }

  describe 'GET #index' do
    it 'returns a successful response' do
      create(:characteristic_option, characteristic: characteristic)
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new CharacteristicOption' do
        expect {
          post :create, params: { characteristic_option: valid_attributes }
        }.to change(CharacteristicOption, :count).by(1)
      end

      it 'renders a JSON response with the new option' do
        post :create, params: { characteristic_option: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new CharacteristicOption' do
        expect {
          post :create, params: { characteristic_option: invalid_attributes }
        }.to change(CharacteristicOption, :count).by(0)
      end
    end
  end
end
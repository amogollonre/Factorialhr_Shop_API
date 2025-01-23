require 'rails_helper'

RSpec.describe ItemCharacteristicsController, type: :controller do
  let(:item) { create(:item) }
  let(:characteristic) { create(:characteristic) }
  let(:characteristic_option) { create(:characteristic_option, characteristic: characteristic) }
  
  let(:valid_attributes) {
    {
      item_id: item.id,
      characteristic_id: characteristic.id,
      characteristic_option_id: characteristic_option.id,
      active: true
    }
  }

  let(:invalid_attributes) {
    { item_id: nil }
  }

  describe 'GET #index' do
    it 'returns a successful response' do
      create(:item_characteristic, 
        item: item, 
        characteristic: characteristic,
        characteristic_option: characteristic_option
      )
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new ItemCharacteristic' do
        expect {
          post :create, params: { item_characteristic: valid_attributes }
        }.to change(ItemCharacteristic, :count).by(1)
      end

      it 'renders a JSON response with the new characteristic' do
        post :create, params: { item_characteristic: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new ItemCharacteristic' do
        expect {
          post :create, params: { item_characteristic: invalid_attributes }
        }.to change(ItemCharacteristic, :count).by(0)
      end
    end
  end
end
require 'rails_helper'

RSpec.describe CharacteristicsController, type: :controller do
  let(:category) { create(:category) }
  let(:valid_attributes) {
    { category_id: category.id, name: 'Color', required: true }
  }

  let(:invalid_attributes) {
    { name: '' }
  }

  describe 'GET #index' do
    it 'returns a successful response' do
      create(:characteristic, category: category)
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Characteristic' do
        expect {
          post :create, params: { characteristic: valid_attributes }
        }.to change(Characteristic, :count).by(1)
      end

      it 'renders a JSON response with the new characteristic' do
        post :create, params: { characteristic: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Characteristic' do
        expect {
          post :create, params: { characteristic: invalid_attributes }
        }.to change(Characteristic, :count).by(0)
      end
    end
  end
end
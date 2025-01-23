require 'swagger_helper'

RSpec.describe 'Item Characteristics API', type: :request do
  path '/item_characteristics' do
    get 'Lista características de productos' do
      tags 'Item Characteristics'
      produces 'application/json'
      
      response '200', 'características encontradas' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              item_id: { type: :integer },
              characteristic_id: { type: :integer },
              characteristic_option_id: { type: :integer },
              active: { type: :boolean },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            },
            required: ['item_id', 'characteristic_id', 'characteristic_option_id']
          }
        run_test!
      end
    end

    post 'Crea característica de producto' do
      tags 'Item Characteristics'
      consumes 'application/json'
      parameter name: :item_characteristic, in: :body, schema: {
        type: :object,
        properties: {
          item_characteristic: {
            type: :object,
            properties: {
              item_id: { type: :integer },
              characteristic_id: { type: :integer },
              characteristic_option_id: { type: :integer },
              active: { type: :boolean }
            },
            required: ['item_id', 'characteristic_id', 'characteristic_option_id']
          }
        }
      }

      response '201', 'característica creada' do
        let(:item_characteristic) { { item_characteristic: { 
          item_id: 1, 
          characteristic_id: 1,
          characteristic_option_id: 1 
        } } }
        run_test!
      end

      response '422', 'datos inválidos' do
        let(:item_characteristic) { { item_characteristic: { item_id: nil } } }
        run_test!
      end
    end
  end

  path '/item_characteristics/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Obtiene una característica de producto' do
      tags 'Item Characteristics'
      produces 'application/json'
      response '200', 'característica encontrada' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            item_id: { type: :integer },
            characteristic_id: { type: :integer },
            characteristic_option_id: { type: :integer },
            active: { type: :boolean }
          }
        let(:id) { ItemCharacteristic.create!(
          item_id: 1,
          characteristic_id: 1,
          characteristic_option_id: 1
        ).id }
        run_test!
      end
    end

    patch 'Actualiza característica de producto' do
      tags 'Item Characteristics'
      consumes 'application/json'
      parameter name: :item_characteristic, in: :body, schema: {
        type: :object,
        properties: {
          item_characteristic: {
            type: :object,
            properties: {
              characteristic_option_id: { type: :integer },
              active: { type: :boolean }
            }
          }
        }
      }

      response '200', 'característica actualizada' do
        let(:id) { ItemCharacteristic.create!(
          item_id: 1,
          characteristic_id: 1,
          characteristic_option_id: 1
        ).id }
        let(:item_characteristic) { { item_characteristic: { active: false } } }
        run_test!
      end
    end

    delete 'Elimina característica de producto' do
      tags 'Item Characteristics'
      response '204', 'característica eliminada' do
        let(:id) { ItemCharacteristic.create!(
          item_id: 1,
          characteristic_id: 1,
          characteristic_option_id: 1
        ).id }
        run_test!
      end
    end
  end
end
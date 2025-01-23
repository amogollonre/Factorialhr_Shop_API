# spec/requests/characteristic_options_spec.rb
require 'swagger_helper'

RSpec.describe 'Characteristic Options API', type: :request do
  path '/characteristic_options' do
    get 'Lista opciones de características' do
      tags 'Characteristic Options'
      produces 'application/json'
      
      response '200', 'opciones encontradas' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              characteristic_id: { type: :integer },
              name: { type: :string },
              description: { type: :string },
              price_adjustment: { type: :number },
              in_stock: { type: :boolean },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            },
            required: ['id', 'characteristic_id', 'name', 'price_adjustment', 'in_stock']
          }
        run_test!
      end
    end

    post 'Crea una opción' do
      tags 'Characteristic Options'
      consumes 'application/json'
      parameter name: :characteristic_option, in: :body, schema: {
        type: :object,
        properties: {
          characteristic_option: {
            type: :object,
            properties: {
              characteristic_id: { type: :integer },
              name: { type: :string, maxLength: 100 },
              description: { type: :string },
              price_adjustment: { type: :number },
              in_stock: { type: :boolean }
            },
            required: ['characteristic_id', 'name']
          }
        }
      }

      response '201', 'opción creada' do
        let(:characteristic_option) { { characteristic_option: { characteristic_id: 1, name: 'Rojo' } } }
        run_test!
      end

      response '422', 'datos inválidos' do
        let(:characteristic_option) { { characteristic_option: { name: '' } } }
        run_test!
      end
    end
  end

  path '/characteristic_options/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Obtiene una opción' do
      tags 'Characteristic Options'
      produces 'application/json'

      response '200', 'opción encontrada' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            characteristic_id: { type: :integer },
            name: { type: :string },
            description: { type: :string },
            price_adjustment: { type: :number },
            in_stock: { type: :boolean }
          }
        let(:id) { CharacteristicOption.create!(characteristic_id: 1, name: 'Test').id }
        run_test!
      end

      response '404', 'opción no encontrada' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch 'Actualiza una opción' do
      tags 'Characteristic Options'
      consumes 'application/json'
      parameter name: :characteristic_option, in: :body, schema: {
        type: :object,
        properties: {
          characteristic_option: {
            type: :object,
            properties: {
              name: { type: :string },
              description: { type: :string },
              price_adjustment: { type: :number },
              in_stock: { type: :boolean }
            }
          }
        }
      }

      response '200', 'opción actualizada' do
        let(:id) { CharacteristicOption.create!(characteristic_id: 1, name: 'Test').id }
        let(:characteristic_option) { { characteristic_option: { name: 'Updated' } } }
        run_test!
      end
    end

    delete 'Elimina una opción' do
      tags 'Characteristic Options'
      
      response '204', 'opción eliminada' do
        let(:id) { CharacteristicOption.create!(characteristic_id: 1, name: 'Test').id }
        run_test!
      end
    end
  end
end
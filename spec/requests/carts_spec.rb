require 'swagger_helper'

RSpec.describe 'Carts API', type: :request do
  path '/carts' do
    get 'Lista carritos' do
      tags 'Carts'
      produces 'application/json'
      
      response '200', 'carritos encontrados' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              user_id: { type: :integer },
              status: { type: :string },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            },
            required: ['id', 'user_id', 'status']
          }
        run_test!
      end
    end

    post 'Crea un carrito' do
      tags 'Carts'
      consumes 'application/json'
      parameter name: :cart, in: :body, schema: {
        type: :object,
        properties: {
          cart: {
            type: :object,
            properties: {
              user_id: { type: :integer },
              status: { type: :string, enum: ['pending', 'completed', 'cancelled'] }
            },
            required: ['user_id']
          }
        }
      }

      response '201', 'carrito creado' do
        let(:cart) { { cart: { user_id: 1 } } }
        run_test!
      end

      response '422', 'datos inválidos' do
        let(:cart) { { cart: { user_id: nil } } }
        run_test!
      end
    end
  end

  path '/carts/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Obtiene un carrito' do
      tags 'Carts'
      produces 'application/json'

      response '200', 'carrito encontrado' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            user_id: { type: :integer },
            status: { type: :string },
            created_at: { type: :string, format: 'date-time' },
            updated_at: { type: :string, format: 'date-time' }
          }
        let(:id) { Cart.create!(user_id: 1).id }
        run_test!
      end

      response '404', 'carrito no encontrado' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch 'Actualiza un carrito' do
      tags 'Carts'
      consumes 'application/json'
      parameter name: :cart, in: :body, schema: {
        type: :object,
        properties: {
          cart: {
            type: :object,
            properties: {
              status: { type: :string, enum: ['pending', 'completed', 'cancelled'] }
            }
          }
        }
      }

      response '200', 'carrito actualizado' do
        let(:id) { Cart.create!(user_id: 1).id }
        let(:cart) { { cart: { status: 'completed' } } }
        run_test!
      end
    end

    delete 'Elimina un carrito' do
      tags 'Carts'
      response '204', 'carrito eliminado' do
        let(:id) { Cart.create!(user_id: 1).id }
        run_test!
      end
    end
  end
end
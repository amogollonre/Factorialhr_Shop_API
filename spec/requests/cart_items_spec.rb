require 'swagger_helper'

RSpec.describe 'Cart Items API', type: :request  do
  path '/cart_items' do
    get 'Lista items del carrito' do
      tags 'Cart Items'
      produces 'application/json'
      
      response '200', 'items encontrados' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              cart_id: { type: :integer },
              item_id: { type: :integer },
              selected_options: { type: :object },
              final_price: { type: :number },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            },
            required: ['id', 'cart_id', 'item_id', 'selected_options', 'final_price']
          }
        run_test!
      end
    end

    post 'Agrega item al carrito' do
      tags 'Cart Items'
      consumes 'application/json'
      parameter name: :cart_item, in: :body, schema: {
        type: :object,
        properties: {
          cart_item: {
            type: :object,
            properties: {
              cart_id: { type: :integer },
              item_id: { type: :integer },
              selected_options: { 
                type: :object,
                additionalProperties: true
              },
              final_price: { type: :number }
            },
            required: ['cart_id', 'item_id']
          }
        }
      }

      response '201', 'item agregado' do
        let(:cart_item) { { cart_item: { cart_id: 1, item_id: 1, selected_options: {}, final_price: 99.99 } } }
        run_test!
      end

      response '422', 'datos inválidos' do
        let(:cart_item) { { cart_item: { cart_id: nil } } }
        run_test!
      end
    end
  end

  path '/cart_items/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Obtiene un item del carrito' do
      tags 'Cart Items'
      produces 'application/json'

      response '200', 'item encontrado' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            cart_id: { type: :integer },
            item_id: { type: :integer },
            selected_options: { type: :object },
            final_price: { type: :number },
            created_at: { type: :string, format: 'date-time' },
            updated_at: { type: :string, format: 'date-time' }
          }
        let(:id) { CartItem.create!(cart_id: 1, item_id: 1, selected_options: {}, final_price: 99.99).id }
        run_test!
      end

      response '404', 'item no encontrado' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch 'Actualiza un item del carrito' do
      tags 'Cart Items'
      consumes 'application/json'
      parameter name: :cart_item, in: :body, schema: {
        type: :object,
        properties: {
          cart_item: {
            type: :object,
            properties: {
              selected_options: { type: :object },
              final_price: { type: :number }
            }
          }
        }
      }

      response '200', 'item actualizado' do
        let(:id) { CartItem.create!(cart_id: 1, item_id: 1, selected_options: {}, final_price: 99.99).id }
        let(:cart_item) { { cart_item: { final_price: 149.99 } } }
        run_test!
      end
    end

    delete 'Elimina un item del carrito' do
      tags 'Cart Items'
      
      response '204', 'item eliminado' do
        let(:id) { CartItem.create!(cart_id: 1, item_id: 1, selected_options: {}, final_price: 99.99).id }
        run_test!
      end
    end
  end
end
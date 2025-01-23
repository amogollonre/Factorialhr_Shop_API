require 'swagger_helper'

RSpec.describe 'Option Images API', type: :request do
  path '/option_images' do
    get 'Lista imágenes de opciones' do
      tags 'Option Images'
      produces 'application/json'
      
      response '200', 'imágenes encontradas' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              characteristic_option_id: { type: :integer },
              url: { type: :string, maxLength: 255 },
              alt_text: { type: :string, maxLength: 255, nullable: true },
              is_main: { type: :boolean },
              display_order: { type: :integer },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            },
            required: ['characteristic_option_id', 'url']
          }
        run_test!
      end
    end

    post 'Crea imagen de opción' do
      tags 'Option Images'
      consumes 'application/json'
      parameter name: :option_image, in: :body, schema: {
        type: :object,
        properties: {
          option_image: {
            type: :object,
            properties: {
              characteristic_option_id: { type: :integer },
              url: { type: :string, maxLength: 255 },
              alt_text: { type: :string, maxLength: 255 },
              is_main: { type: :boolean },
              display_order: { type: :integer }
            },
            required: ['characteristic_option_id', 'url']
          }
        }
      }

      response '201', 'imagen creada' do
        let(:option_image) { {
          option_image: {
            characteristic_option_id: 1,
            url: 'http://example.com/image.jpg'
          }
        } }
        run_test!
      end

      response '422', 'datos inválidos' do
        let(:option_image) { { option_image: { characteristic_option_id: nil } } }
        run_test!
      end
    end
  end

  path '/option_images/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Obtiene una imagen de opción' do
      tags 'Option Images'
      produces 'application/json'

      response '200', 'imagen encontrada' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            characteristic_option_id: { type: :integer },
            url: { type: :string },
            alt_text: { type: :string },
            is_main: { type: :boolean },
            display_order: { type: :integer }
          }
        let(:id) { OptionImage.create!(
          characteristic_option_id: 1,
          url: 'http://example.com/image.jpg'
        ).id }
        run_test!
      end
    end

    patch 'Actualiza imagen de opción' do
      tags 'Option Images'
      consumes 'application/json'
      parameter name: :option_image, in: :body, schema: {
        type: :object,
        properties: {
          option_image: {
            type: :object,
            properties: {
              url: { type: :string },
              alt_text: { type: :string },
              is_main: { type: :boolean },
              display_order: { type: :integer }
            }
          }
        }
      }

      response '200', 'imagen actualizada' do
        let(:id) { OptionImage.create!(
          characteristic_option_id: 1,
          url: 'http://example.com/image.jpg'
        ).id }
        let(:option_image) { { option_image: { alt_text: 'Nueva descripción' } } }
        run_test!
      end
    end

    delete 'Elimina imagen de opción' do
      tags 'Option Images'
      response '204', 'imagen eliminada' do
        let(:id) { OptionImage.create!(
          characteristic_option_id: 1,
          url: 'http://example.com/image.jpg'
        ).id }
        run_test!
      end
    end
  end
end
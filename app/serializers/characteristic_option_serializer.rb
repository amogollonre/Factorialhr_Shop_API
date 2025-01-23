class CharacteristicOptionSerializer < ApplicationSerializer
  attributes :id, :characteristic_id, :name, :description, :price_adjustment, :in_stock, :created_at, :updated_at
  belongs_to :characteristic
  has_many :option_images
 end
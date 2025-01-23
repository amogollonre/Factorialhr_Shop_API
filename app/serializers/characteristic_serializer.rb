class CharacteristicSerializer < ApplicationSerializer
  attributes :id, :category_id, :name, :description, :required, :active, :created_at, :updated_at
  belongs_to :category
  has_many :characteristic_options
 end
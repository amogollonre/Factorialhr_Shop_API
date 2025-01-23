class ItemCharacteristicSerializer < ApplicationSerializer
  attributes :id, :item_id, :characteristic_id, :characteristic_option_id, :active, :created_at, :updated_at
  belongs_to :item
  belongs_to :characteristic
  belongs_to :characteristic_option
 end
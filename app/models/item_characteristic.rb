class ItemCharacteristic < ApplicationRecord
  belongs_to :item
  belongs_to :characteristic
  belongs_to :characteristic_option
 
  validates :active, inclusion: { in: [true, false] }
  validates :characteristic_id, uniqueness: { scope: :item_id }
 end
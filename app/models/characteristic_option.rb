class CharacteristicOption < ApplicationRecord
  belongs_to :characteristic
  has_many :option_images
  has_many :item_characteristics
  has_many :if_restrictions, class_name: 'CategoryOptionRestriction', 
           foreign_key: 'if_characteristic_option_id'
  has_many :then_restrictions, class_name: 'CategoryOptionRestriction', 
           foreign_key: 'then_characteristic_option_id'
 
  validates :name, presence: true, length: { maximum: 100 },
            uniqueness: { scope: :characteristic_id }
  validates :price_adjustment, numericality: true
 end
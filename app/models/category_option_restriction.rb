class CategoryOptionRestriction < ApplicationRecord
  belongs_to :category
  belongs_to :if_characteristic_option, class_name: 'CharacteristicOption'
  belongs_to :then_characteristic_option, class_name: 'CharacteristicOption'
 
  validates :restriction_type, length: { maximum: 50 }
  validates :active, inclusion: { in: [true, false] }
  validates :if_characteristic_option_id, uniqueness: { 
    scope: [:category_id, :then_characteristic_option_id] 
  }
 end
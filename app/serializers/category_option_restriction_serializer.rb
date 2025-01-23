class CategoryOptionRestrictionSerializer < ApplicationSerializer
  attributes :id, :category_id, :if_characteristic_option_id, :then_characteristic_option_id, 
             :restriction_type, :active, :created_at, :updated_at
  belongs_to :category
  belongs_to :if_characteristic_option
  belongs_to :then_characteristic_option
 end
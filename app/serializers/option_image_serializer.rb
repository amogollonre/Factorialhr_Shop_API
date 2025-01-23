class OptionImageSerializer < ApplicationSerializer
  attributes :id, :characteristic_option_id, :url, :alt_text, :is_main, :display_order, :created_at, :updated_at
  belongs_to :characteristic_option
 end
class Cart < ApplicationRecord
    has_many :cart_items
   
    validates :user_id, presence: true
    validates :status, presence: true, length: { maximum: 50 }
   end
   
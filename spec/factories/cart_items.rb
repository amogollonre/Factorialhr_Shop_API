FactoryBot.define do
  factory :cart_item do
    cart
    item
    selected_options { {} }
    final_price { 99.99 }
  end
end
FactoryBot.define do
  factory :item do
    category
    name { "Test Item" }
    description { "Test Description" }
    base_price { 99.99 }
    active { true }
  end
end
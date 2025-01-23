FactoryBot.define do
  factory :characteristic do
    category
    name { "Test Characteristic" }
    required { false }
    active { true }
  end
end
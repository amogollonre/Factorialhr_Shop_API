FactoryBot.define do
  factory :item_image do
    item
    url { "http://example.com/test.jpg" }
    alt_text { "Test Image" }
    is_main { false }
  end
end
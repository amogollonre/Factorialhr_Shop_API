FactoryBot.define do
  factory :option_image do
    characteristic_option
    url { "http://example.com/test.jpg" }
    alt_text { "Test Image" }
    is_main { false }
  end
end
FactoryBot.define do
  factory :url do
    original_url { "MyString" }
    short_url { "MyString" }
    visit_count { 1 }
    user { nil }
  end
end

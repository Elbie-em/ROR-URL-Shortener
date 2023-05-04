FactoryBot.define do
  factory :url do
    original_url { Faker::Internet.unique.url(scheme: 'https') }
    user
  end
end
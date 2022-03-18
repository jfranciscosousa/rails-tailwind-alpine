FactoryBot.define do
  factory :todo do
    content { Faker::Lorem.unique.sentence }
    user
  end
end

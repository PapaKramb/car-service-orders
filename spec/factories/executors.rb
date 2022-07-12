FactoryBot.define do
  factory :executor do
    sequence(:name) { |n| "Name#{n}" }

    trait :invalid do
      name { nil }
    end
  end
end

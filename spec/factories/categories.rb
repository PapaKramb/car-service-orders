FactoryBot.define do
  factory :category do
    sequence(:category_name) { |n| "CategoryName#{n}" }

    trait :invalid do
      category_name { nil }
    end
  end
end

FactoryBot.define do
  factory :order do
    sequence(:customers_name) { |n| "CustomersName#{n}" }

    trait :invalid do
      customers_name { nil }
    end
  end
end

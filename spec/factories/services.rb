FactoryBot.define do
  factory :service do
    sequence(:service_name) { |n| "ServiceName#{n}" }

    trait :invalid do
      service_name { nil }
    end
  end
end

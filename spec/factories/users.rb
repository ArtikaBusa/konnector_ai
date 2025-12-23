FactoryBot.define do
  factory :user do
    name { "Test User" }
    sequence(:email) { |n| "user#{n}@test.com" }
    password { "password" }
    authentication_token { SecureRandom.hex(20) } # ✅ REQUIRED

    trait :admin do
      role { :admin }
    end

    trait :school_admin do
      role { :school_admin }
    end

    trait :student do
      role { :student }
    end
  end
end

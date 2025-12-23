FactoryBot.define do
  factory :school do
    name { "Test School" }
    address { "Mumbai" }
    association :school_admin, factory: [:user, :school_admin]
  end
end

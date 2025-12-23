FactoryBot.define do
  factory :enrollment do
    user
    batch
    status { :pending }
  end
end

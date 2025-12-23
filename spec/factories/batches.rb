FactoryBot.define do
  factory :batch do
    name { "Batch A" }
    start_date { Date.current }
    end_date { Date.current + 1.month }
    course
  end
end

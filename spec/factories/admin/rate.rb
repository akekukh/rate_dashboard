FactoryBot.define do
  factory :rate, class: Admin::Rate do
    sequence(:rate) { |n| n }
    sequence(:finished_at) { DateTime.now + 1.day }
  end
end

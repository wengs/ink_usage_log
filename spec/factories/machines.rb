FactoryGirl.define do
  factory :machine do
    sequence(:name) { |n| "machine_#{n}" }
  end
end

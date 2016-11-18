FactoryGirl.define do
  factory :ink_usage do
    association(:machine_part_number)
    association(:user)
    sequence(:lot_number) { |n| "lot_number_#{n}" }
    exp_code 10.days.from_now
  end
end

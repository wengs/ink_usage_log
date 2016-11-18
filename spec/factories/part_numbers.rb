FactoryGirl.define do
  factory :part_number do
    sequence(:number) { |n| "number_#{n}" }
    sequence(:name) { |n| "name_#{n}" }

    association(:color)
  end

end

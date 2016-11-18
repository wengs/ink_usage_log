FactoryGirl.define do
  factory :machine_part_number do
    association(:machine)
    association(:part_number)
  end

end

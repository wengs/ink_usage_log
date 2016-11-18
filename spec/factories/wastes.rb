FactoryGirl.define do
  factory :waste do
    association(:user)
    association(:machine)
    level (1..5).to_a.sample
  end
end

FactoryGirl.define do
  factory :color do
    sequence(:name) { |n| "color_#{n}" }
  end

end

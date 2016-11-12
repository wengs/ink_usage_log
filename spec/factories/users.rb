FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@test.com" }
    password 'Test1234'
    password_confirmation 'Test1234'
  end
end

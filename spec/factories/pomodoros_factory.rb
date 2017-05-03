FactoryGirl.define do
  factory :pomodoro do
    description { Faker::Name.name }
    duration { Faker::Number.between(1, 25) }
  end
end

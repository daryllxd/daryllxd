# frozen_string_literal: true
FactoryGirl.define do
  factory :pomodoro do
    description { Faker::Name.name }
    duration { Faker::Number.between(1, 25) }
    started_at { Date.current }
  end
end

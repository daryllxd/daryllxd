# frozen_string_literal: true
FactoryGirl.define do
  factory :expense do
    description { Faker::Name.name }
    amount { 50 }
    spent_on { Date.current }
  end
end

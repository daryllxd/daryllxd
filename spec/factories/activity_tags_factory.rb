# frozen_string_literal: true
FactoryGirl.define do
  factory :activity_tag do
    trait :programming do
      name { 'Programming' }
    end

    trait :daryllxd do
      name { 'Daryllxd' }
    end
  end
end

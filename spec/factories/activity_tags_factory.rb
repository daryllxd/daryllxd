# frozen_string_literal: true
FactoryGirl.define do
  factory :activity_tag do
    trait :programming do
      name { 'Programming' }
      shortcut { 'p' }
    end

    trait :daryllxd do
      name { 'Daryllxd' }
      shortcut { 'd' }
    end
  end
end

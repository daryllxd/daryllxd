# frozen_string_literal: true
FactoryGirl.define do
  factory :budget_tag do
    trait :food do
      name 'food'
      shortcut 'f'
    end

    trait :uber do
      name 'uber'
      shortcut 'u'
    end
  end
end

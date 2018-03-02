# frozen_string_literal: true

# Namespace Pomodoro::Entities  to `pv`.
FactoryGirl.define do
  factory :pe_activity_tag, class: Pomodoros::Entities::ActivityTag do
    initializes_as_value_object

    trait :programming do
      name { 'Programming' }
    end

    trait :writing do
      name { 'Writing' }
    end
  end
end

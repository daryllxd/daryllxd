# frozen_string_literal: true

# Namespace Pomodoro::Values  to `pv`.
FactoryGirl.define do
  factory :pv_activity_tag, class: Pomodoros::Values::ActivityTag do
    initializes_as_value_object

    trait :programming do
      name { 'Programming' }
    end

    trait :writing do
      name { 'Writing' }
    end
  end
end

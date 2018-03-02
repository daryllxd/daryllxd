# frozen_string_literal: true

# Namespace Pomodoro::Entities  to `pv`.
FactoryGirl.define do
  factory :pe_pomodoro, class: Pomodoros::Entities::Pomodoro do
    initializes_as_value_object

    sequence(:id)
    description   { 'Basket weaving' }
    duration      { 5 }
    started_at    { Time.now }

    trait :programming do
      activity_tags { [create(:pe_activity_tag, :programming)] }
    end

    trait :writing do
      activity_tags { [create(:pe_activity_tag, :writing)] }
    end
  end
end

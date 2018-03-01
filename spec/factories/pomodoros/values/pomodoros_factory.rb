# frozen_string_literal: true

# Namespace Pomodoro::Values  to `pv`.
FactoryGirl.define do
  factory :pv_pomodoro, class: Pomodoros::Values::Pomodoro do
    initializes_as_value_object

    sequence(:id)
    description   { 'Basket weaving' }
    duration      { 5 }
    started_at    { Time.now }
  end
end

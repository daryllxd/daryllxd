# frozen_string_literal: true
# Namespace Pomodoro::Values  to `pv`.

FactoryGirl.define do
  factory :pv_pomodoro_collection, class: Pomodoros::Values::PomodoroCollection do
    initializes_as_value_object

    pomodoros []
  end
end

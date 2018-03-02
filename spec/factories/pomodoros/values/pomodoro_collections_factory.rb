# frozen_string_literal: true

# Namespace Pomodoro::Entities  to `pv`.

FactoryGirl.define do
  factory :pe_pomodoro_collection, class: Pomodoros::Entities::PomodoroCollection do
    initializes_as_value_object

    pomodoros []
  end
end

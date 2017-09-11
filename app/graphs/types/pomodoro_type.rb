# frozen_string_literal: true
PomodoroType = GraphQL::ObjectType.define do
  name 'Pomodoro'
  description 'A user'

  field :id, types.Int
  field :duration, types.Int
  field :description, types.String
end

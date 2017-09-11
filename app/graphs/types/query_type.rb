# frozen_string_literal: true
QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root of this schema'

  field :pomodoro do
    type PomodoroType
    argument :id, !types.ID
    resolve proc { |_obj, args, _ctx|
      Pomodoro.find(args[:id])
    }
  end

  field :expense do
    type ExpenseType

    argument :id, !types.ID

    resolve proc { |_obj, args, _ctx|
      Expense.find(args[:id])
    }
  end
end

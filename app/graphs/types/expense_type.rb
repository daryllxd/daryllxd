# frozen_string_literal: true
ExpenseType = GraphQL::ObjectType.define do
  name 'Expense'
  description 'A user'

  field :id, types.Int
  field :amount, types.Int
  field :description, types.String
end

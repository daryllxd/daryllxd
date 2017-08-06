# frozen_string_literal: true
module Financerinos
  module Expenses
    class CreateService
      attr_reader :description, :amount

      def initialize(description:, amount:)
        @description = description
        @amount = amount
      end

      def call
        ActiveRecord::Base.transaction do
          create_expense

          return DaryllxdError.new unless created_expense.valid?
          return created_expense
        end
      end

      private

      def create_expense
        @memoized_created_expense ||= Expense.create(create_expense_attributes)
      end

      def create_expense_attributes
        {
          description: description,
          amount: amount
        }
      end

      def created_expense
        @memoized_created_expense
      end
    end
  end
end

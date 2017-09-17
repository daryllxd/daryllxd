# frozen_string_literal: true
module Financerinos
  module Expenses
    class TagResolver
      attr_reader :tag_string

      def initialize(tag_string:)
        @tag_string = tag_string
      end

      def call
        if tag_string.present?
          BudgetTag.where(shortcut: tag_string.split(''))
        else
          []
        end
      end
    end
  end
end

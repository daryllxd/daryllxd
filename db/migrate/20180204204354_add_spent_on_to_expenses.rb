# frozen_string_literal: true
class AddSpentOnToExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :expenses, :spent_on, :date

    Expense.all.each do |ex|
      ex.update_attributes(spent_on: ex.created_at)
    end

    change_column_null :expenses, :spent_on, false
  end
end

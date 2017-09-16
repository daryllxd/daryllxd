# frozen_string_literal: true
class CreateExpenseBudgetTags < ActiveRecord::Migration[5.0]
  def change
    create_table :expense_budget_tags do |t|
      t.references :expense, null: false
      t.references :budget_tag, null: false

      t.timestamps
    end

    add_foreign_key :expense_budget_tags, :expenses
    add_foreign_key :expense_budget_tags, :budget_tags
  end
end

# frozen_string_literal: true
class RemoveStringFromBudgetTag < ActiveRecord::Migration[5.0]
  def change
    remove_column :budget_tags, :string
  end
end

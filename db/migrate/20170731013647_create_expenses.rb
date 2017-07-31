# frozen_string_literal: true
class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.string :description, null: false
      t.integer :amount, null: false

      t.timestamps
    end
  end
end

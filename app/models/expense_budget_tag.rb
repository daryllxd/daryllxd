# frozen_string_literal: true
# == Schema Information
#
# Table name: expense_budget_tags
#
#  id            :integer          not null, primary key
#  expense_id    :integer          not null
#  budget_tag_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_expense_budget_tags_on_budget_tag_id  (budget_tag_id)
#  index_expense_budget_tags_on_expense_id     (expense_id)
#
# Foreign Keys
#
#  fk_rails_825fdf52d0  (expense_id => expenses.id)
#  fk_rails_b50bdf413f  (budget_tag_id => budget_tags.id)
#

class ExpenseBudgetTag < ApplicationRecord
  validates_presence_of :expense
  validates_presence_of :budget_tag

  belongs_to :expense
  belongs_to :budget_tag
end

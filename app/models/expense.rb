# frozen_string_literal: true
# == Schema Information
#
# Table name: expenses
#
#  id          :integer          not null, primary key
#  description :string           not null
#  amount      :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Expense < ApplicationRecord
  validates :description, presence: true

  validates :amount, presence: true
  validates_numericality_of :amount, greater_than_or_equal_to: 0, only_integer: true
end

# frozen_string_literal: true
# == Schema Information
#
# Table name: budget_tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  shortcut   :string           not null
#  string     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BudgetTag < ApplicationRecord
  validates :name, presence: true
  validates :shortcut, presence: true
end

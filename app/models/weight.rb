# frozen_string_literal: true
# == Schema Information
#
# Table name: weights
#
#  id          :integer          not null, primary key
#  value       :decimal(, )      not null
#  recorded_at :date             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Weight < ApplicationRecord
  validates :value, presence: true
end

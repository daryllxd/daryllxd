# frozen_string_literal: true

# == Schema Information
#
# Table name: pomodoros
#
#  id          :integer          not null, primary key
#  duration    :integer          not null
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  started_at  :datetime         not null
#

class Pomodoro < ApplicationRecord
  validates :description, presence: true
  validates :duration, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :pomodoro_activity_tags, dependent: :destroy
  has_many :activity_tags, through: :pomodoro_activity_tags

  def create_activity_tag!(activity_tag)
    pomodoro_activity_tags.create!(activity_tag: activity_tag)
  end
end

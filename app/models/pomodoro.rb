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
#

class Pomodoro < ApplicationRecord
  validates :description, presence: true
  validates :duration, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :pomodoro_activity_tags
  has_many :activity_tags, through: :pomodoro_activity_tags

  def self.for_date(date: Date.current)
    includes(:activity_tags)
      .where("created_at BETWEEN '#{date.beginning_of_day}' AND '#{date.end_of_day}'")
      .order('id DESC')
  end
end

# == Schema Information
#
# Table name: activity_tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ActivityTag < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :pomodoro_activity_tags
  has_many :pomodoros, through: :pomodoro_activity_tags
end

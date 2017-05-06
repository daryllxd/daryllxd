# == Schema Information
#
# Table name: pomodoro_activity_tags
#
#  id              :integer          not null, primary key
#  pomodoro_id     :integer
#  activity_tag_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_pomodoro_activity_tags_on_activity_tag_id  (activity_tag_id)
#  index_pomodoro_activity_tags_on_pomodoro_id      (pomodoro_id)
#

class PomodoroActivityTag < ApplicationRecord
  belongs_to :pomodoro
  belongs_to :activity_tag
end

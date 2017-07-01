# frozen_string_literal: true
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
# Foreign Keys
#
#  fk_rails_011c06fc06  (pomodoro_id => pomodoros.id)
#  fk_rails_b9a3418b57  (activity_tag_id => activity_tags.id)
#

class PomodoroActivityTag < ApplicationRecord
  belongs_to :pomodoro, foreign_key: :pomodoro_id
  belongs_to :activity_tag, foreign_key: :activity_tag_id
end

# frozen_string_literal: true
class AddForeignKeysToPomodoroActivityTags < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :pomodoro_activity_tags, :activity_tags
    add_foreign_key :pomodoro_activity_tags, :pomodoros
  end
end

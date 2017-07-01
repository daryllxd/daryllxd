# frozen_string_literal: true
class CreatePomodoroActivityTags < ActiveRecord::Migration[5.0]
  def change
    create_table :pomodoro_activity_tags do |t|
      t.references :pomodoro
      t.references :activity_tag

      t.timestamps
    end
  end
end

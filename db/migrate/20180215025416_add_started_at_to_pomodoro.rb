# frozen_string_literal: true
class AddStartedAtToPomodoro < ActiveRecord::Migration[5.0]
  def change
    add_column :pomodoros, :started_at, :datetime

    Pomodoro.all.each do |pomo|
      pomo.update_attributes(started_at: pomo.created_at)
    end

    change_column_null :pomodoros, :started_at, false
  end
end

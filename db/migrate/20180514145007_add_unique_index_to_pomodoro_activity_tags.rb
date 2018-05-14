class AddUniqueIndexToPomodoroActivityTags < ActiveRecord::Migration[5.1]
  def change
    add_index :pomodoro_activity_tags, [:pomodoro_id, :activity_tag_id], unique: true
  end
end

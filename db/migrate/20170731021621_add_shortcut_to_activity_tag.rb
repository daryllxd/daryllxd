# frozen_string_literal: true
class AddShortcutToActivityTag < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_tags, :shortcut, :string
  end
end

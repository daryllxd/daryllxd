# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :subtitle
      t.string :amazon_url
      t.string :authors, array: true, default: []
      t.string :description
      t.string :google_books_url
      t.string :thumbnail_url
      t.string :subtitle
      t.jsonb :google_books_api_data
      t.date :google_books_scraped_at

      t.timestamps
    end
  end
end

class CreateWeights < ActiveRecord::Migration[5.0]
  def change
    create_table :weights do |t|
      t.decimal :value, null: false
      t.date :recorded_at, null: false

      t.timestamps
    end
  end
end

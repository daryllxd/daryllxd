class CreateActivityTags < ActiveRecord::Migration[5.0]
  def change
    create_table :activity_tags do |t|
      t.string :name, null: false

      t.timestamps
    end

    ActivityTag.create(name: 'Golfcrow')
    ActivityTag.create(name: 'Programming')
    ActivityTag.create(name: 'Daryllxd')
    ActivityTag.create(name: 'Self-Improvement')
    ActivityTag.create(name: 'Coursera')
    ActivityTag.create(name: 'Charisma')
  end
end

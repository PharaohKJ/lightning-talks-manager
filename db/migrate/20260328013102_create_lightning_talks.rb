class CreateLightningTalks < ActiveRecord::Migration[8.1]
  def change
    create_table :lightning_talks do |t|
      t.references :event, null: false, foreign_key: true
      t.string :speaker_name
      t.string :title

      t.timestamps
    end
  end
end

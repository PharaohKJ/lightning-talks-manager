class AddDurationToLightningTalks < ActiveRecord::Migration[8.1]
  def change
    add_column :lightning_talks, :duration, :integer
  end
end

class AddPositionToLightningTalks < ActiveRecord::Migration[8.1]
  def change
    add_column :lightning_talks, :position, :integer
  end
end

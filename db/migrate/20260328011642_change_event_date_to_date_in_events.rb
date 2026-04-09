class ChangeEventDateToDateInEvents < ActiveRecord::Migration[8.1]
  def up
    change_column :events, :event_date, :date
  end

  def down
    change_column :events, :event_date, :datetime
  end
end

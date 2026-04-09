class AddTimeLimitPerLtToEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :time_limit_per_lt, :integer
  end
end

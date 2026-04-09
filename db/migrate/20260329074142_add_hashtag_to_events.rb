class AddHashtagToEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :hashtag, :string
  end
end

class AddDiscardedAtToDevelopers < ActiveRecord::Migration[6.1]
  def change
    add_column :developers, :discarded_at, :datetime
    add_index :developers, :discarded_at
  end
end

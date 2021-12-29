class AddDiscardedAtToTechnologies < ActiveRecord::Migration[6.1]
  def change
    add_column :technologies, :discarded_at, :datetime
    add_index :technologies, :discarded_at
  end
end

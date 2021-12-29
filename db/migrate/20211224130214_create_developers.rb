class CreateDevelopers < ActiveRecord::Migration[6.1]
  def change
    create_table :developers do |t|
      t.string :first_name
      t.string :last_name
      t.belongs_to :project
      t.timestamps
    end
  end
end

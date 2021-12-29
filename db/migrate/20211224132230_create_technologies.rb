class CreateTechnologies < ActiveRecord::Migration[6.1]
  def change
    create_table :technologies do |t|
      t.string :name
      t.belongs_to :project
      t.timestamps
    end
  end
end

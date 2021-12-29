class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.datetime :start_date, null: false, default: Time.now
      t.datetime :end_date
      t.timestamps
    end
  end
end

class ChangeDefaultStartDateProject < ActiveRecord::Migration[6.1]
  def up
    change_column_default :projects, :start_date, nil
  end

  def down
    change_column_default :projects, :start_date, Time.now
  end
end

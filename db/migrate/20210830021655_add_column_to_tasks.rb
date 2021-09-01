class AddColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :expired_at, :datetime, null:false,default:'1000-01-01 00:00:00.000000'
  end
end

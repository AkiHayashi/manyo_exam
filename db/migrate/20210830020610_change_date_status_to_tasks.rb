class ChangeDateStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :description, :string
  end
end

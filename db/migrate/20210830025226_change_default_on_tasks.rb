class ChangeDefaultOnTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :expired_at, from: '1000-01-01 00:00:00.000000', to:'2021-08-031 00:00:00.000000'
  end
end

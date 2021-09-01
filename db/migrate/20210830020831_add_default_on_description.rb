class AddDefaultOnDescription < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :description, from: false, to: true
  end
end

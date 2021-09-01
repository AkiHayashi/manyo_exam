class AddDefaultOnTitle < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :title, from: false, to: true
  end
end

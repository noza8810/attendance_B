class RenameDesignationWorkTimeColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :designation_work_time, :work_time
  end
end

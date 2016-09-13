class UpdatePermissionModel < ActiveRecord::Migration
  def change
    change_column :permissions, :name, :text
    rename_column :permissions, :name, :names
  end
end

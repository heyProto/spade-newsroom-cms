class ModifyFilterData < ActiveRecord::Migration
  def change
    change_column :filter_data, :skills, :text
    change_column :filter_data, :toolset, :text
  end
end

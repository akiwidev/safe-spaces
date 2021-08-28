class AddColumnToKobans < ActiveRecord::Migration[6.0]
  def change
    add_column :kobans, :longitude, :float
    add_column :kobans, :latitude, :float
  end
end

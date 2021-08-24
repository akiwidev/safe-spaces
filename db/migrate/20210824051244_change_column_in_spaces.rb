class ChangeColumnInSpaces < ActiveRecord::Migration[6.0]
  def change
    rename_column :spaces, :lon, :longitude
    rename_column :spaces, :lat, :latitude
  end
end

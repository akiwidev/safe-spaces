class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :emergency_name, :string
    add_column :users, :emergency_num, :string
  end
end

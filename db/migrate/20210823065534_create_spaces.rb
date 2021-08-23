class CreateSpaces < ActiveRecord::Migration[6.0]
  def change
    create_table :spaces do |t|
      t.text :conditions
      t.boolean :available, default: false
      t.string :address
      t.float :lon
      t.float :lat
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

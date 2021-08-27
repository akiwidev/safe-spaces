class AddUserToMessages < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :user, null: false, foreign_key: true
    remove_column :messages, :sender_id
    remove_column :messages, :receiver_id
  end
end

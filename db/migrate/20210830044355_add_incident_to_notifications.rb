class AddIncidentToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_reference :notifications, :incident, foreign_key: true
  end
end

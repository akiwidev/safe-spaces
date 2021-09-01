class NotificationChannel < ApplicationCable::Channel
  def subscribed
    notification = Notification.all
    stream_for notification
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

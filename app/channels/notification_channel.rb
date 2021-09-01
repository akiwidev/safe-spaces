class NotificationChannel < ApplicationCable::Channel
  def subscribed
    notification = Notification.find(params[:id])
    stream_from current_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

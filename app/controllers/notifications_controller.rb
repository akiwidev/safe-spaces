class NotificationsController < ApplicationController
  def index
    @notifications = policy_scope(Notification)
    # @notifications = current_user.notifications
    # authorize @notification
  end

  def show
    @notification = Notification.find(params[:id])
    @notification.mark_as_read!
    authorize @notification
    if @notification.type == "SpaceNotification"
      redirect_to user_path(@notification.recipient)
    else
      redirect_to @notification.to_notification.url
    end
  end
end

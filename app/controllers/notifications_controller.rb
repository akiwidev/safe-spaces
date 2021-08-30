class NotificationsController < ApplicationController
  def index
    @notifications = policy_scope(Notification)
    # @notifications = current_user.notifications
    # authorize @notification
  end
end

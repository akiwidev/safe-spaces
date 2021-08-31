# To deliver this notification:
#
# CommentNotification.with(post: @post).deliver_later(current_user)
# CommentNotification.with(incident: @incident).deliver(current_user)

class SpaceNotification < Noticed::Base
  # Add your delivery methods
  deliver_by :database
  deliver_by :action_cable
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  def message
    "#{params[:space].user.first_name.capitalize} might need your safe space. Make your space unavailable if you are not there."
  end
  #
  def url
    user_path(params[:recipient])
  end

end

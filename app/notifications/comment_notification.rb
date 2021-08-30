# To deliver this notification:
#
# CommentNotification.with(post: @post).deliver_later(current_user)
# CommentNotification.with(incident: @incident).deliver(current_user)

class CommentNotification < Noticed::Base
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
    "#{params[:incident].user.first_name.capitalize} needs your help!"
  end
  #
  def url
    incident_path(params[:incident])
  end

end

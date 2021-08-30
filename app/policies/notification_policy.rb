class NotificationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.notifications.newest_first
    end
  end

  def show?
    user == record.recipient
  end
end

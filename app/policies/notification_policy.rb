class NotificationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.notifications
    end
  end
end

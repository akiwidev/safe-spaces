class IncidentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    user == record.user || user == record.space.user
  end

  def create?
    true
  end

  def show?
    true
  end
end

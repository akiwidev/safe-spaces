class IncidentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    owner_or_creator?
  end

  def create?
    true
  end

  def show?
    true
  end

  def call?
    owner_or_creator?
  end

  private

  def owner_or_creator?
    user == record.user || user == record.space.user
  end
end

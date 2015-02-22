class LeadPolicy < ApplicationPolicy
  attr_reader :user, :lead

  def initialize(user, lead)
    @user = user
    @lead = lead
  end

  def index?
    (!user.banned? && user.tos?) || user.admin?
  end

  def show?
    (!user.banned? && user.tos? && lead.owner?(user)) || user.admin?
  end

  def create?
    (!user.banned? && user.tos?) || user.admin?
  end

  def update?
    (!user.banned? && user.tos? && lead.owner?(user)) || user.admin?
  end

  def destroy?
    (!user.banned? && user.tos? && lead.owner?(user)) || user.admin?
  end

  class Scope < Scope
    def resolve
      #scope.where(id: user)
      scope
    end
  end
end

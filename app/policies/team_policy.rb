class TeamPolicy < ApplicationPolicy
  attr_reader :user, :team

  def initialize(user, team)
    @user = user
    @team = team
  end

  def index?
    (!user.banned? && user.tos?) || user.admin?
  end

  def show?
    (!user.banned? && user.tos?) || user.admin?
  end

  def create?
    (!user.banned? && user.tos?) || user.admin?
  end

  def update?
    (!user.banned? && user.tos? && team.owner?(user)) || user.admin?
  end

  def destroy?
    (!user.banned? && user.tos? && team.owner?(user)) || user.admin?
  end

  class Scope < Scope
    def resolve
      #scope.where(id: user)
      scope
    end
  end
end

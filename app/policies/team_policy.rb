# app/policies/team_policy.rb

class TeamPolicy < ApplicationPolicy
  attr_reader :user, :team

  def initialize(user, team)
    @user = user
    @team = team
  end

  def index?
    user.admin? || user.valid?
  end

  def show?
    user.admin? || user.valid?
  end

  def create?
    user.admin? || user.valid?
  end

  def update?
    user.admin? || (user.valid? && team.owner?(user))
  end

  def destroy?
    user.admin? || (user.valid? && team.owner?(user))
  end

  class Scope < Scope
    def resolve
      #scope.where(id: user)
      scope
    end
  end
end

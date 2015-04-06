# app/policies/team_policy.rb

class TeamPolicy < ApplicationPolicy
  attr_reader :user, :team

  def initialize(user, team)
    @user = user
    @team = team
  end

  def index?
    user.admin? || user.is_valid?
  end

  def show?
    user.admin? || user.is_valid?
  end

  def create?
    user.admin? || user.is_valid?
  end

  def update?
    user.admin? || (user.is_valid? && (team.unowned? || team.owner?(user)))
  end

  def destroy?
    user.admin? || (user.is_valid? && (team.unowned? || team.owner?(user)))
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(:user_id => user.id)
      end
    end
  end
end

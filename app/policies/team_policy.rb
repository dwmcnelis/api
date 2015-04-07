# app/policies/team_policy.rb

class TeamPolicy < ApplicationPolicy
  attr_reader :user, :team

  def initialize(user, team)
    @user = user
    @team = team
  end

  # admin or valid user
  def index?
    user.admin? || user.is_valid?
  end

  # admin or valid user
  def show?
    user.admin? || user.is_valid?
  end

  # admin or valid user
  def create?
    user.admin? || user.is_valid?
  end

  # admin or valid owner or unowned
  def update?
    user.admin? || (user.is_valid? && (team.unowned? || team.owner?(user)))
  end

  # admin or valid owner or unowned
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

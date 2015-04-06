# app/policies/tag_policy.rb

class TagPolicy < ApplicationPolicy
  attr_reader :user, :tag

  def initialize(user, tag)
    @user = user
    @tag = tag
  end

  def index?
    user.admin? || user.is_valid?
  end

  def show?
    user.admin? || (user.is_valid? && (tag.unowned? || tag.owner?(user)))
  end

  def create?
    user.admin? || user.is_valid?
  end

  def update?
    user.admin? || (user.is_valid? && (tag.unowned? || tag.owner?(user)))
  end

  def destroy?
    user.admin? || (user.is_valid? && (tag.unowned? || tag.owner?(user)))
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

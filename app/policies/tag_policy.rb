# app/policies/tag_policy.rb

class TagPolicy < ApplicationPolicy
  attr_reader :user, :tag

  def initialize(user, tag)
    @user = user
    @tag = tag
  end

  def index?
    user.admin? || user.valid?
  end

  def show?
    user.admin? || (user.valid? && (tag.unowned? || tag.owner?(user)))
  end

  def create?
    user.admin? || user.valid?
  end

  def update?
    user.admin? || (user.valid? && (tag.unowned? || tag.owner?(user)))
  end

  def destroy?
    user.admin? || (user.valid? && (tag.unowned? || tag.owner?(user)))
  end

  class Scope < Scope
    def resolve
      #scope.where(id: user)
      scope
    end
  end
end

# app/policies/client_policy.rb

class ClientPolicy < ApplicationPolicy
  attr_reader :user, :client

  def initialize(user, client)
    @user = user
    @client = client
  end

  def index?
    user.admin? || user.valid?
  end

  def show?
    user.admin? || (user.valid? && client.owner?(user))
  end

  def create?
    user.admin? || user.valid?
  end

  def update?
    user.admin? || (user.valid? && client.owner?(user))
  end

  def destroy?
    user.admin? || (user.valid? && client.owner?(user))
  end

  class Scope < Scope
    def resolve
      #scope.where(id: user)
      scope
    end
  end
end

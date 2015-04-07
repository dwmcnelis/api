# app/policies/client_policy.rb

class ClientPolicy < ApplicationPolicy
  attr_reader :user, :client

  def initialize(user, client)
    @user = user
    @client = client
  end

  # admin or valid user
  def index?
    user.admin? || user.is_valid?
  end

  # admin or valid owner
  def show?
    user.admin? || (user.is_valid? && client.owner?(user))
  end

  # admin or valid user
  def create?
    user.admin? || user.is_valid?
  end

  # admin or valid owner
  def update?
    user.admin? || (user.is_valid? && client.owner?(user))
  end

  # admin or valid owner
  def destroy?
    user.admin? || (user.is_valid? && client.owner?(user))
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

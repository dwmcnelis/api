# app/policies/client_policy.rb



class ClientPolicy < ApplicationPolicy
  attr_reader :user, :client

  def initialize(user, client)
    @user = user
    @client = client
  end

  def index?
    user.admin? || user.is_valid?
  end

  def show?
    user.admin? || (user.is_valid? && client.owner?(user))
  end

  def create?
    user.admin? || user.is_valid?
  end

  def update?
    user.admin? || (user.is_valid? && client.owner?(user))
  end

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

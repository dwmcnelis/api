class ClientPolicy < ApplicationPolicy
  attr_reader :user, :client

  def initialize(user, client)
    @user = user
    @client = client
  end

  def index?
    (!user.banned? && user.tos?) || user.admin?
  end

  def show?
    (!user.banned? && user.tos? && client.owner?(user)) || user.admin?
  end

  def create?
    (!user.banned? && user.tos?) || user.admin?
  end

  def update?
    (!user.banned? && user.tos? && client.owner?(user)) || user.admin?
  end

  def destroy?
    (!user.banned? && user.tos? && client.owner?(user)) || user.admin?
  end

  class Scope < Scope
    def resolve
      #scope.where(id: user)
      scope
    end
  end
end

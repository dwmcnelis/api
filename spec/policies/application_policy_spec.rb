# spec/policies/application_policy_spec.rb

require 'rails_helper'

describe ApplicationPolicy do
  subject { described_class }

  let!(:admin_user) { create(:user, :admin_user) }
  let!(:user) { create(:user) }

  permissions :index? do
    it "denies access if ordinary user" do
      expect(subject).not_to permit(user)
    end

    it "denies access if user is admin" do
      expect(subject).not_to permit(admin_user)
    end
  end # index?

  permissions :show? do
    it "denies access if ordinary user" do
      expect(subject).not_to permit(user)
    end

    it "denies access if user is admin" do
      expect(subject).not_to permit(admin_user)
    end
  end # show?

  permissions :read? do
    it "denies access if ordinary user" do
      expect(subject).not_to permit(user)
    end

    it "denies access if user is admin" do
      expect(subject).not_to permit(admin_user)
    end
  end # show?

  permissions :create? do
    it "denies access if ordinary user" do
      expect(subject).not_to permit(user)
    end

    it "denies access if user is admin" do
      expect(subject).not_to permit(admin_user)
    end
  end # create?

  permissions :new? do
    it "denies access if ordinary user" do
      expect(subject).not_to permit(user)
    end

    it "denies access if user is admin" do
      expect(subject).not_to permit(admin_user)
    end
  end # new?

  permissions :update? do
    it "denies access if ordinary user" do
      expect(subject).not_to permit(user)
    end

    it "denies access if user is admin" do
      expect(subject).not_to permit(admin_user)
    end
  end # update?

  permissions :edit? do
    it "denies access if ordinary user" do
      expect(subject).not_to permit(user)
    end

    it "denies access if user is admin" do
      expect(subject).not_to permit(admin_user)
    end
  end # edit?

  permissions :destroy? do
    it "denies access if ordinary user" do
      expect(subject).not_to permit(user)
    end

    it "denies access if user is admin" do
      expect(subject).not_to permit(admin_user)
    end
  end # destroy?

  permissions :delete? do
    it "denies access if ordinary user" do
      expect(subject).not_to permit(user)
    end

    it "denies access if user is admin" do
      expect(subject).not_to permit(admin_user)
    end
  end # delete?

  describe 'scope' do
    it 'resolves scope for admin' do  
      expect(ApplicationPolicy::Scope.new(admin_user, Tag.all).resolve).to eq(Tag.all)
    end

    it 'resolves scope for owner' do  
      expect(ApplicationPolicy::Scope.new(user, Tag.all).resolve).to eq(Tag.all)
    end
  end

end # ApplicationPolicy

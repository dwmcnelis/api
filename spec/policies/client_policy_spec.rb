# spec/policies/client_policy_spec.rb

require 'rails_helper'

describe ClientPolicy do
  subject { described_class }

  let!(:admin_user) { create(:user, :admin_user) }
  let!(:with_client_user) { create(:user) }
  let!(:client1) { create(:client, user_id: with_client_user.id) }
  let!(:client2) { create(:client, user_id: with_client_user.id) }
  let!(:client3) { create(:client, user_id: with_client_user.id) }
  let!(:other_user) { create(:user) }
  let!(:other_user_client) { create(:client, user_id: other_user.id) }
  let!(:without_client_user) { create(:user) }
  let!(:invalid_user) { create(:user, :tos_not_accepted) }
  let!(:invalid_user_client) { create(:client, user_id: invalid_user.id) }

  permissions :index? do
    it "grants access if user is admin" do
      expect(subject).to permit(admin_user)
    end

    it "grants access if user is valid" do
      expect(subject).to permit(with_client_user)
    end

    it "denies access if user is invalid" do
      expect(subject).not_to permit(invalid_user)
    end
  end # index?

  permissions :show? do
    it "grants access if user is admin" do
      expect(subject).to permit(admin_user, client1)
    end

    it "grants access if user is valid and is owner" do
      expect(subject).to permit(with_client_user, client1)
    end

    it "denies access if user is invalid and is owner" do
      expect(subject).not_to permit(invalid_user, invalid_user_client)
    end

    it "denies access if user is valid and is not owner" do
      expect(subject).not_to permit(other_user, client1)
    end
  end # show?

  permissions :create? do
    it "grants access if user is admin" do
      expect(subject).to permit(admin_user)
    end

    it "grants access if user is valid" do
      expect(subject).to permit(with_client_user)
    end

    it "denies access if user is invalid" do
      expect(subject).not_to permit(invalid_user)
    end
  end # show?

  permissions :update? do
    it "grants access if user is admin" do
      expect(subject).to permit(admin_user, client1)
    end

    it "grants access if user is valid and is owner" do
      expect(subject).to permit(with_client_user, client1)
    end

    it "denies access if user is invalid and is owner" do
      expect(subject).not_to permit(invalid_user, invalid_user_client)
    end

    it "denies access if user is valid and is not owner" do
      expect(subject).not_to permit(other_user, client1)
    end
  end # update?

  permissions :destroy? do
    it "grants access if user is admin" do
      expect(subject).to permit(admin_user, client1)
    end

    it "grants access if user is valid and is owner" do
      expect(subject).to permit(with_client_user, client1)
    end

    it "denies access if user is invalid and is owner" do
      expect(subject).not_to permit(invalid_user, invalid_user_client)
    end

    it "denies access if user is valid and is not owner" do
      expect(subject).not_to permit(other_user, client1)
    end
  end # destroy?

  describe 'scope' do
    it 'resolves scope for admin' do  
      expect(ClientPolicy::Scope.new(admin_user, Client).resolve.count).to eq(Client.count)
    end

    it 'resolves scope for owner' do  
      expect(ClientPolicy::Scope.new(with_client_user, Client).resolve.count).to eq(with_client_user.clients.count)
    end
  end

end # ClientPolicy

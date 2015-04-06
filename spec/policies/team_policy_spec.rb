# spec/policies/team_policy_spec.rb

require 'rails_helper'

describe TeamPolicy do
  subject { described_class }

  let!(:admin_user) { create(:user, :admin_user) }
  let!(:unowned_team) { create(:team) }
  let!(:with_team_user) { create(:user) }
  let!(:team1) { create(:team, user_id: with_team_user.id) }
  let!(:team2) { create(:team, user_id: with_team_user.id) }
  let!(:team3) { create(:team, user_id: with_team_user.id) }
  let!(:other_user) { create(:user) }
  let!(:other_user_team) { create(:team, user_id: other_user.id) }
  let!(:without_team_user) { create(:user) }
  let!(:invalid_user) { create(:user, :tos_not_accepted) }
  let!(:invalid_user_team) { create(:team, user_id: invalid_user.id) }

  permissions :index? do
    it "grants access if user is admin" do
      expect(subject).to permit(admin_user)
    end

    it "grants access if user is valid" do
      expect(subject).to permit(with_team_user)
    end

    it "denies access if user is invalid" do
      expect(subject).not_to permit(invalid_user)
    end
  end # index?

  permissions :show? do
    it "grants access if user is admin" do
      expect(subject).to permit(admin_user, team1)
    end

    it "grants access if user is valid and is owner" do
      expect(subject).to permit(with_team_user, team1)
    end

    it "grants access if user is valid and is unowned team" do
      expect(subject).to permit(with_team_user, unowned_team)
    end

    it "denies access if user is invalid and is owner" do
      expect(subject).not_to permit(invalid_user, invalid_user_team)
    end
  end # show?

  permissions :create? do
    it "grants access if user is admin" do
      expect(subject).to permit(admin_user)
    end

    it "grants access if user is valid" do
      expect(subject).to permit(with_team_user)
    end

    it "denies access if user is invalid" do
      expect(subject).not_to permit(invalid_user)
    end
  end # show?

  permissions :update? do
    it "grants access if user is admin" do
      expect(subject).to permit(admin_user, team1)
    end

    it "grants access if user is valid and is owner" do
      expect(subject).to permit(with_team_user, team1)
    end

    it "grants access if user is valid and is unowned team" do
      expect(subject).to permit(with_team_user, unowned_team)
    end

    it "denies access if user is invalid and is owner" do
      expect(subject).not_to permit(invalid_user, invalid_user_team)
    end

    it "denies access if user is valid and is not owner" do
      expect(subject).not_to permit(other_user, team1)
    end
  end # update?

  permissions :destroy? do
    it "grants access if user is admin" do
      expect(subject).to permit(admin_user, team1)
    end

    it "grants access if user is valid and is owner" do
      expect(subject).to permit(with_team_user, team1)
    end

    it "grants access if user is valid and is unowned team" do
      expect(subject).to permit(with_team_user, unowned_team)
    end

    it "denies access if user is invalid and is owner" do
      expect(subject).not_to permit(invalid_user, invalid_user_team)
    end

    it "denies access if user is valid and is not owner" do
      expect(subject).not_to permit(other_user, team1)
    end
  end # destroy?

  describe 'scope' do
    it 'resolves scope for admin' do  
      expect(ClientPolicy::Scope.new(admin_user, Team).resolve.count).to eq(Team.count)
    end

    it 'resolves scope for owner' do  
      expect(ClientPolicy::Scope.new(with_team_user, Team).resolve.count).to eq(with_team_user.teams.count)
    end
  end

end # TeamPolicy

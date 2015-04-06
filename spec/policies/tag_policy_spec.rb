# spec/policies/tag_policy_spec.rb

require 'rails_helper'

describe TagPolicy do
  subject { described_class }

  let!(:admin_user) { create(:user, :admin_user) }
  let!(:unowned_tag) { create(:tag) }
  let!(:with_tag_user) { create(:user) }
  let!(:tag1) { create(:tag, user_id: with_tag_user.id) }
  let!(:tag2) { create(:tag, user_id: with_tag_user.id) }
  let!(:tag3) { create(:tag, user_id: with_tag_user.id) }
  let!(:other_user) { create(:user) }
  let!(:other_user_tag) { create(:tag, user_id: other_user.id) }
  let!(:without_tag_user) { create(:user) }
  let!(:invalid_user) { create(:user, :tos_not_accepted) }
  let!(:invalid_user_tag) { create(:tag, user_id: invalid_user.id) }

  permissions :index? do
    it "grants access if user is admin" do
      expect(subject).to permit(admin_user)
    end

    it "grants access if user is valid" do
      expect(subject).to permit(with_tag_user)
    end

    it "denies access if user is invalid" do
      expect(subject).not_to permit(invalid_user)
    end
  end # index?

  permissions :show? do
    it "grants access if user is admin" do
      expect(subject).to permit(admin_user, tag1)
    end

    it "grants access if user is valid and is owner" do
      expect(subject).to permit(with_tag_user, tag1)
    end

    it "grants access if user is valid and is unowned tag" do
      expect(subject).to permit(with_tag_user, unowned_tag)
    end

    it "denies access if user is invalid and is owner" do
      expect(subject).not_to permit(invalid_user, invalid_user_tag)
    end

    it "denies access if user is valid and is not owner" do
      expect(subject).not_to permit(other_user, tag1)
    end
  end # show?

  permissions :create? do
    it "grants access if user is admin" do
      expect(subject).to permit(admin_user)
    end

    it "grants access if user is valid" do
      expect(subject).to permit(with_tag_user)
    end

    it "denies access if user is invalid" do
      expect(subject).not_to permit(invalid_user)
    end
  end # show?

  permissions :update? do
    it "grants access if user is admin" do
      expect(subject).to permit(admin_user, tag1)
    end

    it "grants access if user is valid and is owner" do
      expect(subject).to permit(with_tag_user, tag1)
    end

    it "grants access if user is valid and is unowned tag" do
      expect(subject).to permit(with_tag_user, unowned_tag)
    end

    it "denies access if user is invalid and is owner" do
      expect(subject).not_to permit(invalid_user, invalid_user_tag)
    end

    it "denies access if user is valid and is not owner" do
      expect(subject).not_to permit(other_user, tag1)
    end
  end # update?

  permissions :destroy? do
    it "grants access if user is admin" do
      expect(subject).to permit(admin_user, tag1)
    end

    it "grants access if user is valid and is owner" do
      expect(subject).to permit(with_tag_user, tag1)
    end

    it "grants access if user is valid and is unowned tag" do
      expect(subject).to permit(with_tag_user, unowned_tag)
    end

    it "denies access if user is invalid and is owner" do
      expect(subject).not_to permit(invalid_user, invalid_user_tag)
    end

    it "denies access if user is valid and is not owner" do
      expect(subject).not_to permit(other_user, tag1)
    end
  end # destroy?

  describe 'scope' do
    it 'resolves scope for admin' do  
      expect(ClientPolicy::Scope.new(admin_user, Tag).resolve.count).to eq(Tag.count)
    end

    it 'resolves scope for owner' do  
      expect(ClientPolicy::Scope.new(with_tag_user, Tag).resolve.count).to eq(with_tag_user.tags.count)
    end
  end

end # TagPolicy

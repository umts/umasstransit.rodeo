require 'rails_helper'

describe User do
  describe 'simple validations' do
    it 'prevents users from having the same email' do
      create :user, email: 'bsmith@example.com'
      invalid_user = build :user, email: 'bsmith@example.com'
      expect(invalid_user).not_to be_valid
    end
  end

  describe 'approve!' do
    it 'updates approved to true' do
      user = create :user, :unapproved
      expect { user.approve! }.to change(user, :approved).to true
    end
  end

  describe 'Devise method overwrites' do
    describe 'active_for_authentication' do
      subject { create :user, :unapproved }
      it { is_expected.not_to be_active_for_authentication }
    end

    describe 'inactive_message' do
      it 'returns :not_approved for an unapproved user' do
        user = create :user, :unapproved
        expect(user.inactive_message).to eql :not_approved
      end
    end
  end

end

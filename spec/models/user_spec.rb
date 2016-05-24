require 'rails_helper'

describe User do
  describe 'simple validations' do
    it 'prevents users from having the same email' do
      create :user, email: 'bsmith@example.com'
      invalid_user = build :user, email: 'bsmith@example.com'
      expect(invalid_user).not_to be_valid
    end
  end
end

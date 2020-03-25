# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'deleting a user' do
  context 'with admin privilege' do
    it 'deletes user' do
      create :user
      admin = create :user, admin: true
      login_as admin
      visit admin_users_url
      click_on 'Remove', match: :first
      expect(page).to have_text 'User has been removed.'
    end
  end
  context 'with master of ceremonies privilege' do
    it 'will not delete a user' do
      create :user
      master_of_ceremonies = create :user, master_of_ceremonies: true
      login_as master_of_ceremonies
      visit admin_users_url
      click_on 'Remove', match: :first
      expect(page).to have_text 'You are not authorized to make that action.'
    end
  end
  context 'when deleting current user' do
    it 'deletes user and redirects to sign in' do
      when_current_user_is :admin
      visit admin_users_url
      click_on 'Remove'
      expect(current_path).to eql new_user_session_path
    end
  end
end

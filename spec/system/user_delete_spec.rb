# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'deleting a user' do
  context 'with admin privilege' do
    before do
      create :user
      when_current_user_is :admin
      visit admin_users_path
    end

    it 'deletes user' do
      click_on 'Remove', match: :first
      expect(page).to have_text 'User has been removed.'
    end
  end

  context 'with master of ceremonies privilege' do
    before do
      create :user
      when_current_user_is :master_of_ceremonies
      visit admin_users_path
    end

    it 'will not delete a user' do
      click_on 'Remove', match: :first
      expect(page).to have_text 'You are not authorized to make that action.'
    end
  end

  context 'when deleting the current user' do
    before do
      when_current_user_is :admin
      visit admin_users_path
    end

    it 'deletes user and redirects to sign in' do
      click_on 'Remove'
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end

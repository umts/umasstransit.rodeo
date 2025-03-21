# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'assigning roles' do
  context 'with admin privilege' do
    before do
      when_current_user_is :admin
      visit admin_users_path
    end

    it 'assigns one role to user' do
      check 'user_master_of_ceremonies'
      click_on 'Save'
      expect(page).to have_text 'User has been updated'
    end

    it 'assigns multiple roles to user' do
      check 'user_master_of_ceremonies'
      check 'user_circle_check_scorer'
      click_on 'Save'
      expect(page).to have_text 'User has been updated'
    end
  end

  context 'with master of ceremonies privilege' do
    before do
      when_current_user_is :master_of_ceremonies
      visit admin_users_path
    end

    it 'does not permit access to the user list' do
      expect(page).to have_text 'You are not authorized to take that action'
    end
  end
end

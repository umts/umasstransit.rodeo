# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'interacting with the menu bar' do
  before do
    when_current_user_is :anybody
    visit root_path
  end

  describe 'signing out a user' do
    it 'signs out the user' do
      click_on 'Logout'
      expect(page).to have_text 'Signed out successfully.'
    end
  end

  describe 'editing a user account' do
    it 'allows the user to edit account information' do
      click_on 'Edit Account'
      expect(page).to have_current_path(edit_user_registration_path)
    end
  end
end

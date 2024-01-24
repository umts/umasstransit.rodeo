# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'login requests' do
  before do
    when_current_user_is nil
  end

  it 'is accessible from the welcome page' do
    visit welcome_participants_path
    within('.login-instructions') { click_on 'here' }
    expect(page).to have_current_path new_user_registration_path
  end

  context 'when requesting a login' do
    let(:new_user) { build(:user) }

    before do
      visit new_user_registration_path
      fill_in 'Name', with: new_user.name
      fill_in 'Email', with: new_user.email
      fill_in 'Password', with: new_user.password
      fill_in 'Password confirmation', with: new_user.password_confirmation
    end

    it 'redirects to the root' do
      click_on 'Send request'
      expect(page).to have_current_path root_path
    end

    it 'informs you of your pending request' do
      click_on 'Send request'
      expected = 'Request sent. You can log in once your request has been approved.'
      expect(page).to have_text(expected)
    end
  end

  context 'when logging in without approval' do
    let(:user) { create(:user, :unapproved) }

    before do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      within('form') { click_on 'Log in' }
    end

    it 'gives you a helpful message' do
      expected = 'Your account must be approved by an administrator before you can log in.'
      expect(page).to have_text(expected)
    end
  end
end

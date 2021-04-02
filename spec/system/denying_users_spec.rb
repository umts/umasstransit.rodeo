# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'denying a user' do
  let!(:user) { create :user, :unapproved }

  before do
    when_current_user_is :admin
    visit manage_admin_users_path
  end

  it 'removes the user' do
    click_on 'Deny'
    expect(User.find_by(id: user)).not_to be_present
  end

  it 'redirects to the manage users page' do
    click_on 'Deny'
    expect(page).to have_current_path manage_admin_users_path, ignore_query: true
  end

  it 'informs you of success' do
    click_on 'Deny'
    expect(page).to have_text 'User has been removed'
  end

  it 'does not show the user anymore' do
    click_on 'Deny'
    expect(page).to have_text 'No users with pending approval'
  end
end

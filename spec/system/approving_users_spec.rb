# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'approving a user' do
  let!(:user) { create(:user, :unapproved) }

  before do
    when_current_user_is :admin
    visit manage_admin_users_path
  end

  it 'approves the user' do
    click_on 'Approve'
    expect(user.reload).to be_approved
  end

  it 'informs you of the approval' do
    click_on 'Approve'
    expect(page).to have_text "#{user.name} has been approved."
  end

  it 'redirects to the index' do
    click_on 'Approve'
    expect(page).to have_current_path manage_admin_users_path, ignore_query: true
  end
end

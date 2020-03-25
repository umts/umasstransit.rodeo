# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'approving a user' do
  let!(:user) { create :user, :unapproved }
  it 'works' do
    when_current_user_is :admin
    visit manage_admin_users_path
    click_on 'Approve'
    expect(current_path).to eq manage_admin_users_path
    expect(page).to have_text "#{user.name} has been approved."
    expect(page).to have_text 'No users with pending approval'
    expect(user.reload).to be_approved
  end
end

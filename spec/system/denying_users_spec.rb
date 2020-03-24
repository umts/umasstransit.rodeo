# frozen_string_literal: true

require 'rails_helper'

describe 'denying a user' do
  let!(:user) { create :user, :unapproved }
  it 'works' do
    when_current_user_is :admin
    visit manage_admin_users_path
    click_on 'Deny'
    expect(current_path).to eq manage_admin_users_path
    expect(page).to have_text 'User has been removed'
    expect(page).to have_text 'No users with pending approval'
    expect(User.find_by id: user).to be nil
  end
end

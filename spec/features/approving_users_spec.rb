require 'rails_helper'

describe 'approving a user' do
  let!(:user) { create :user, :unapproved }
  it 'works' do
    when_current_user_is :admin
    visit manage_admin_users_url
    click_on 'Approve'
    expect(page).to have_text "#{user.name} has been approved."
    expect(page).to have_text 'No users with pending approval'
  end
end

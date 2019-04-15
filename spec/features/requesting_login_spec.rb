# frozen_string_literal: true

require 'rails_helper'

describe 'requesting a login' do
  it 'works as expected' do
    when_current_user_is nil
    visit welcome_participants_url
    within('.login-instructions') { click_on 'here' }
    expect(page.current_url).to eql new_user_registration_url

    user = build(:user)
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_on 'Send request'

    expect(page.current_url).to eql root_url
    expect(page).to have_text(
      'Request sent. You can log in once your request has been approved.'
    )
  end

  it 'gives you a helpful message if you try to log in before being approved' do
    user = create :user, :unapproved
    visit new_user_session_url
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    within('.actions') { click_on 'Log in' }
    expect(page).to have_text(
      'Your account must be approved by an administrator before you can log in.'
    )
  end
end

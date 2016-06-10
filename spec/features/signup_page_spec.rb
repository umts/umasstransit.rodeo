require 'rails_helper'

describe 'signing up' do
  context 'a invalid user' do
    it 'does not create the user' do
      visit new_user_registration_url
      fill_in 'user_name', with: 'Foo Bar'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      expect do
        within('.actions'){ click_on 'Sign up' }
      end.to change { User.count }.by 0
    end
  end
  context 'a valid user' do
    it 'creates the user' do
      visit new_user_registration_url
      fill_in 'user_name', with: 'Foo Bar'
      fill_in 'user_email', with: 'foo@valid.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      expect do
        within('.actions'){ click_on 'Sign up' }
      end.to change { User.count }.by 1
    end
  end
  context 'after signup' do
    it 'allows the user to only view scoreboard' do
      user = create :user
      create :participant
      login_as user
      visit root_path
      expect do
        within('nav').to have_text 'Scoreboard'
        within('nav').not_to have_text 'Maneuver'
        within('nav').not_to have_text 'Circle Check'
        within('nav').not_to have_text 'Quiz'
        within('nav').not_to have_text 'Participants'
        within('nav').not_to have_text 'Buses'
        within('nav').not_to have_text 'Roles'
      end
    end
  end
end

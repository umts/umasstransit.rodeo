require 'rails_helper'

describe 'signing up' do 
  context 'a invalid user' do 
    it 'does not creae the user' do 
      visit new_user_registration_url
      fill_in 'user_name', with: 'Foo Bar'
      fill_in 'user_email', with: 'foo@invalid'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      expect { 
        within('.actions') do 
          click_on 'Sign up' 
        end }
      .to change { User.count }
      .by 0
    end
  end
  context 'a valid user' do 
    it 'creates the user' do 
      visit new_user_registration_url
      fill_in 'user_name', with: 'Foo Bar'
      fill_in 'user_email', with: 'foo@valid.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      expect { 
        within('.actions') do 
          click_on 'Sign up' 
        end }
      .to change { User.count }
      .by 1
    end
  end
  context 'after signup' do 
    it 'allows the user to only view scoreboard' do 
      user = create :user
      create :participant
      login_as user
      visit root_path
      within 'nav' do 
        expect(page).to have_text 'Scoreboard'
        expect(page).not_to have_text 'Maneuver'
        expect(page).not_to have_text 'Circle Check'
        expect(page).not_to have_text 'Quiz'
        expect(page).not_to have_text 'Participants'
        expect(page).not_to have_text 'Buses'
        expect(page).not_to have_text 'Roles'
      end
    end
  end
end
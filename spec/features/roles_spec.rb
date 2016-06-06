require 'rails_helper'

describe 'assigning roles' do
  context 'with admin privilege' do
    it 'assigns one role to user' do
      admin = create :user, admin: true
      login_as admin
      visit admin_users_url
      check 'user_master_of_ceremonies'
      click_on 'Save'
      expect(page).to have_text 'User has been updated.'
    end
    it 'assigns multiple roles to user' do
      admin = create :user, admin: true
      login_as admin
      visit admin_users_url
      check 'user_master_of_ceremonies'
      check 'user_circle_check_scorer'
      click_on 'Save'
      expect(page).to have_text 'User has been updated.'
    end
  end
  context 'with master of ceremonies privilege' do
    it 'will not assign roles to users' do
      user = create :user, master_of_ceremonies: true
      login_as user
      visit admin_users_url
      check 'user_circle_check_scorer'
      check 'user_judge'
      click_on 'Save'
      expect(page).to have_text 'You are not authorized to make that action.'
    end
  end
end

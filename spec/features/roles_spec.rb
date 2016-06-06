require 'rails_helper'

describe 'assigning roles' do 
  context 'with admin privilege' do 
    it 'assigns one role to user' do 
      admin = create :user, admin: true
      login_as admin
      visit admin_users_url
      binding.pry
      check 'user_master_of_ceremonies'
      click_on 'Save'
      expect(page).to have_text 'User has been updated.'
      expect(admin.master_of_ceremonies).to eql true
    end
    it 'assigns multiple roles to user' do 
      admin = create :user, admin: true
      login_as admin
      visit admin_users_url
      check 'user_master_of_ceremonies'
      check 'user_circle_check_scorer'
      click_on 'Save'
      expect(page).to have_text 'User has been updated.'
      expect(admin.master_of_ceremonies)
      expect(admin.circle_check_scorer).to eql true
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
      expect(user.judge).not_to eql true
      expect(user.circle_check_scorer).not_to eql true
    end
  end
end
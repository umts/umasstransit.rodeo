require 'rails_helper'

describe 'signing out a user' do
 it 'signs out the user' do
   user = create :user
   login_as user
   visit root_url
   click_on 'Logout'
   expect(page).to have_text 'Signed out successfully.'
 end
end

describe 'editing a user account' do
 it 'allows the user to edit account information' do
   user = create :user
   login_as user
   visit root_url
   click_on 'Edit Account'
   expect(current_path).to eql edit_user_registration_path
 end
end
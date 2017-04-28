require 'rails_helper'

describe 'adding a vehicle' do
  context 'with admin privilege' do
    it 'adds the vehicle' do
      when_current_user_is :admin
      visit vehicles_url
      fill_in 'vehicle_number', with: 'Big Yellow Vehicle'
      click_on 'Add'
      expect(page).to have_text 'Vehicle was successfully added.'
    end
  end
  context 'with master of ceremonies privilege' do
    it 'adds the vehicle' do
      when_current_user_is :master_of_ceremonies
      visit vehicles_url
      fill_in 'vehicle_number', with: 'Big Yellow Vehicle'
      click_on 'Add'
      expect(page).to have_text 'Vehicle was successfully added.'
    end
  end
  context 'with judge privilege' do
    it 'will not add a vehicle' do
      when_current_user_is :judge
      visit vehicles_url
      fill_in 'vehicle_number', with: 'Big Yellow Vehicle'
      click_on 'Add'
      expect(page).to have_text 'You are not authorized to make that action.'
    end
  end
  context 'with a number not filled in' do
    it 'explains that number is needed' do
      when_current_user_is :admin
      visit vehicles_url
      click_on 'Add'
      expect(page).to have_text "Number can't be blank"
    end
  end
end

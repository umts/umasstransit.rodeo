require 'rails_helper'

describe 'deleting a vehicle' do
  let!(:vehicle) { create :vehicle }
  context 'with admin privilege' do
    it 'deletes a vehicle' do
      when_current_user_is :admin
      visit vehicles_url
      click_on 'Remove'
      expect(page.find('.notice')).to have_text 'Vehicle was successfully deleted.'
    end
  end

  context 'with master of ceremonies privilege' do
    it 'deletes a vehicle' do
      when_current_user_is :master_of_ceremonies
      visit vehicles_url
      click_on 'Remove'
      expect(page.find('.notice')).to have_text 'Vehicle was successfully deleted.'
    end
  end

  context 'with judge privilege' do
    it 'will not delete a vehicle' do
      when_current_user_is :judge
      visit vehicles_url
      click_on 'Remove'
      expect(page.find('.notice')).to have_text 'You are not authorized to make that action.'
    end
  end
end
